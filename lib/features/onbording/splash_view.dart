import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/routing/app_startup_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _glowController;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _chipsFade;
  late final Animation<Offset> _chipsSlide;
  late final Animation<double> _glowScale;

  final AppStartupService _startupService = AppStartupService();

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _resolveStartupRoute();
  }

  void _initAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _logoScale = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _logoFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
      ),
    );

    _glowScale = Tween(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _chipsFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    _chipsSlide = Tween(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _controller.forward();
    });
  }

  Future<void> _resolveStartupRoute() async {
    final results = await Future.wait([
      Future.delayed(const Duration(seconds: 4)),
      _startupService.resolveInitialRoute(),
    ]);

    if (!mounted) {
      return;
    }

    context.go(results[1] as String);
  }

  @override
  void dispose() {
    _controller.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.colorScheme.surface,
              context.colorScheme.secondary.withValues(alpha: 0.03),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 3),
              _buildLogo(),
              const SizedBox(height: 32),
              _buildTextHeader(),
              const SizedBox(height: 60),
              _buildChips(),
              const Spacer(flex: 2),
              _LoadingDots(color: context.colorScheme.secondary),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return ScaleTransition(
      scale: _logoScale,
      child: FadeTransition(
        opacity: _logoFade,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ScaleTransition(
              scale: _glowScale,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      context.colorScheme.secondary.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.themeColors.card,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: ClipOval(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Image.asset(
                    'assets/images/EduAdvisor_Logo.png',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.school,
                      size: 70,
                      color: context.colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextHeader() {
    return Column(
      children: [
        Text(
          context.l10n.appTitle,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: context.themeColors.textPrimary,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          context.l10n.splashTagline,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: context.themeColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildChips() {
    return SlideTransition(
      position: _chipsSlide,
      child: FadeTransition(
        opacity: _chipsFade,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _chip(context.l10n.smartPlanning, Icons.auto_graph_rounded),
            const SizedBox(width: 16),
            _chip(context.l10n.aiPowered, Icons.bolt_rounded),
          ],
        ),
      ),
    );
  }

  Widget _chip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.themeColors.mutedSurface),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: context.colorScheme.secondary),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: context.themeColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingDots extends StatefulWidget {
  final Color color;
  const _LoadingDots({required this.color});

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) => _buildDot(i)),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final double progress = (_controller.value - (index * 0.15)) % 1.0;
        final double bounce = Curves.easeInOut.transform(
          progress < 0.5 ? progress * 2 : (1 - progress) * 2,
        );
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withValues(
              alpha: 0.2 + (0.8 * bounce.clamp(0, 1)),
            ),
          ),
          transform: Matrix4.translationValues(0, -6 * bounce, 0),
        );
      },
    );
  }
}

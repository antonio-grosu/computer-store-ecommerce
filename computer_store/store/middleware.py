class IpClientMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # behind a proxy the real client is the first address in X-Forwarded-For
        x_forwarded_for = request.META.get("HTTP_X_FORWARDED_FOR")
        if x_forwarded_for:
            request.ip_client = x_forwarded_for.split(",")[0].strip()
        else:
            request.ip_client = request.META.get("REMOTE_ADDR")
        return self.get_response(request)

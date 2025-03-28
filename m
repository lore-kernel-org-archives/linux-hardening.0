Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB835963;
	Fri, 28 Mar 2025 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167262; cv=none; b=WUpxUVSQ5V9F5kh82JWUuT0FMU7waOF1vCrFIPxVF7J3+ma07T6ZcdDrmdZyyLtr9Kvz8b5F0DILjKCIgk87BpSm/Tjn0DaUwsZv4ZgarupeLvp0sufQkp1MnP1eIqWAEWGm7Efkf2tEFLFPCqnpb/NQyqzNFmWLeOpilGfUqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167262; c=relaxed/simple;
	bh=Ur4N8elwGrWj1rS6Eiw35A5mFTwoDB/CX4cOH4JBqEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ge3rewCdsZ2swAoDcqWI0EancFE0BgJOnwNyHin3lWfMzU2gMHvrMcRXpFeAmYpM54Qee/oNFza6Jzz+XXx0VRG4zKrARxrJGO8roREpL/ae9LDNcfc1uR5jxtdxwd4AwmoIx5TREBI/JHT00+7v3LGNysmm+anGWIkixIQnm9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRviPZ9l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRviPZ9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22233C4CEE4;
	Fri, 28 Mar 2025 13:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743167260;
	bh=Ur4N8elwGrWj1rS6Eiw35A5mFTwoDB/CX4cOH4JBqEg=;
	h=Date:From:To:Cc:Subject:From;
	b=HRviPZ9lGA2QulYhpv/x1IpKekLI1XjcHRPs0fWBhuzQ9Vh/rAmkgZaW+t+3r5OTo
	 AxGur5t75PT3txGSURQ9yvzlIKGDGck/lK+txFsLKKjl1Z72ocWi0uf0z7tIvzhKTf
	 CnL9yaPN6Z4q4n1LIAVTPY6Rzw1JdwOjXxY0Ptr83O9seSsI1ozjpSdL58u4F8tkgR
	 Ad5Jnh8EhqXnPr/qVFlLF1mznrmi8fSpc98LsYodjcrNRblbX01+R1re0zt8omFzZK
	 jA/kNYpk0hMYRXIkMcF1MbvXa0Y4L7VDpMjTGbaa5XJpR+oijqgGvUYdNwDGKAKi05
	 gJrlgyypHxsfA==
Date: Fri, 28 Mar 2025 07:07:38 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] platform/chrome: cros_kbd_led_backlight: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z-afGnRbyGs4dHb1@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warnings:

drivers/platform/chrome/cros_kbd_led_backlight.c:141:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/platform/chrome/cros_kbd_led_backlight.c:162:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../platform/chrome/cros_kbd_led_backlight.c  | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index fc27bd7fc4b9..f4c2282129f5 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -137,16 +137,12 @@ static int
 keyboard_led_set_brightness_ec_pwm(struct led_classdev *cdev,
 				   enum led_brightness brightness)
 {
-	struct {
-		struct cros_ec_command msg;
-		struct ec_params_pwm_set_keyboard_backlight params;
-	} __packed buf;
-	struct ec_params_pwm_set_keyboard_backlight *params = &buf.params;
-	struct cros_ec_command *msg = &buf.msg;
+	DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
+			sizeof(struct ec_params_pwm_set_keyboard_backlight));
+	struct ec_params_pwm_set_keyboard_backlight *params =
+			(struct ec_params_pwm_set_keyboard_backlight *)msg->data;
 	struct keyboard_led *keyboard_led = container_of(cdev, struct keyboard_led, cdev);
 
-	memset(&buf, 0, sizeof(buf));
-
 	msg->command = EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT;
 	msg->outsize = sizeof(*params);
 
@@ -158,17 +154,13 @@ keyboard_led_set_brightness_ec_pwm(struct led_classdev *cdev,
 static enum led_brightness
 keyboard_led_get_brightness_ec_pwm(struct led_classdev *cdev)
 {
-	struct {
-		struct cros_ec_command msg;
-		struct ec_response_pwm_get_keyboard_backlight resp;
-	} __packed buf;
-	struct ec_response_pwm_get_keyboard_backlight *resp = &buf.resp;
-	struct cros_ec_command *msg = &buf.msg;
+	DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
+			sizeof(struct ec_response_pwm_get_keyboard_backlight));
+	struct ec_response_pwm_get_keyboard_backlight *resp =
+			(struct ec_response_pwm_get_keyboard_backlight *)msg->data;
 	struct keyboard_led *keyboard_led = container_of(cdev, struct keyboard_led, cdev);
 	int ret;
 
-	memset(&buf, 0, sizeof(buf));
-
 	msg->command = EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT;
 	msg->insize = sizeof(*resp);
 
-- 
2.43.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5812C544;
	Fri, 28 Mar 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743168004; cv=none; b=nTS8WNIDCXsFK0e4piEhk+FzPJWVyGnqh9szB40DXJZJV7EDJo+Xa8av+j6w6CSJ69yqJZZj8FsowPmTNkL///dzxxbpS/LnwJfMeb6W7jY9nrgKGVmOg43FR2e07VJrZ3vejQZhM+IwVTUTyLuesooJJWoyLS/56bCT7ZCb8yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743168004; c=relaxed/simple;
	bh=PbE3P7d+0IgWJs59aXFiaqzoZImTTdZogccba+32FoA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fhMHXXxlMDoOSSCRSi+n6N7C4TGbMtXT+60QNfermDingNv1jZLKFbRR+PE/TDlzdO8xHbumlDb+pbJ3uiiLQ8cikqVm1MVdRouq+6Zh+Tdk6MMuWikOuFXlMVJSXuvODN8lxF7m1/wmnyw4UoqZ7GE3oigNwnvG4+ey80pIj58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyLzW/Me; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyLzW/Me"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B836BC4CEE4;
	Fri, 28 Mar 2025 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743168003;
	bh=PbE3P7d+0IgWJs59aXFiaqzoZImTTdZogccba+32FoA=;
	h=Date:From:To:Cc:Subject:From;
	b=ZyLzW/MeCbWhIBaIKgKM+VyXR7Ri2ulEOJ2nuHK22872cnvXaQSCdx7A8xiyU8548
	 AhpqBe8Dp9ZaRxnntSI9ubUuvhmosXs3rRQRdWsPxVz95/KcG6NP1/w4GofNGNMfAW
	 kajV6c4CsxJcB+pP3v4uAQd3i0KcicOAD9uD0MfU8lZFC+gF+ca9Ib22Q7sujtyFee
	 CgXuX+2dOPKUWedVn6nzb9jjnNoxr6MjQTiwena84eoD1uhoKaTa3BNYx2t3KH45qz
	 akbXubZtbtUVXg8dDqwm1hjOsUCgIq7q+DtztXE6bcL1qMuHNK4N5x21U80NQw5t7F
	 9toMkG0/qWYAg==
Date: Fri, 28 Mar 2025 07:20:00 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] platform/chrome: cros_ec_debugfs: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z-aiAAcIP7sBRtz0@kspp>
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

drivers/platform/chrome/cros_ec_debugfs.c:211:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/platform/chrome/cros_ec_debugfs.c:257:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/platform/chrome/cros_ec_debugfs.c:279:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/platform/chrome/cros_ec_debugfs.c | 52 +++++++++--------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 92ac9a2f9c88..d10f9561990c 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -207,22 +207,15 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
 	char read_buf[EC_USB_PD_MAX_PORTS * 40], *p = read_buf;
 	struct cros_ec_debugfs *debug_info = file->private_data;
 	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
-	struct {
-		struct cros_ec_command msg;
-		union {
-			struct ec_response_usb_pd_control_v1 resp;
-			struct ec_params_usb_pd_control params;
-		};
-	} __packed ec_buf;
-	struct cros_ec_command *msg;
-	struct ec_response_usb_pd_control_v1 *resp;
-	struct ec_params_usb_pd_control *params;
+	DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
+			MAX(sizeof(struct ec_response_usb_pd_control_v1),
+			    sizeof(struct ec_params_usb_pd_control)));
+	struct ec_response_usb_pd_control_v1 *resp =
+			(struct ec_response_usb_pd_control_v1 *)msg->data;
+	struct ec_params_usb_pd_control *params =
+			(struct ec_params_usb_pd_control *)msg->data;
 	int i;
 
-	msg = &ec_buf.msg;
-	params = (struct ec_params_usb_pd_control *)msg->data;
-	resp = (struct ec_response_usb_pd_control_v1 *)msg->data;
-
 	msg->command = EC_CMD_USB_PD_CONTROL;
 	msg->version = 1;
 	msg->insize = sizeof(*resp);
@@ -253,17 +246,15 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
 
 static bool cros_ec_uptime_is_supported(struct cros_ec_device *ec_dev)
 {
-	struct {
-		struct cros_ec_command cmd;
-		struct ec_response_uptime_info resp;
-	} __packed msg = {};
+	DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
+			sizeof(struct ec_response_uptime_info));
 	int ret;
 
-	msg.cmd.command = EC_CMD_GET_UPTIME_INFO;
-	msg.cmd.insize = sizeof(msg.resp);
+	msg->command = EC_CMD_GET_UPTIME_INFO;
+	msg->insize = sizeof(struct ec_response_uptime_info);
 
-	ret = cros_ec_cmd_xfer_status(ec_dev, &msg.cmd);
-	if (ret == -EPROTO && msg.cmd.result == EC_RES_INVALID_COMMAND)
+	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+	if (ret == -EPROTO && msg->result == EC_RES_INVALID_COMMAND)
 		return false;
 
 	/* Other errors maybe a transient error, do not rule about support. */
@@ -275,20 +266,17 @@ static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
 {
 	struct cros_ec_debugfs *debug_info = file->private_data;
 	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
-	struct {
-		struct cros_ec_command cmd;
-		struct ec_response_uptime_info resp;
-	} __packed msg = {};
-	struct ec_response_uptime_info *resp;
+	DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
+			sizeof(struct ec_response_uptime_info));
+	struct ec_response_uptime_info *resp =
+				(struct ec_response_uptime_info *)msg->data;
 	char read_buf[32];
 	int ret;
 
-	resp = (struct ec_response_uptime_info *)&msg.resp;
-
-	msg.cmd.command = EC_CMD_GET_UPTIME_INFO;
-	msg.cmd.insize = sizeof(*resp);
+	msg->command = EC_CMD_GET_UPTIME_INFO;
+	msg->insize = sizeof(*resp);
 
-	ret = cros_ec_cmd_xfer_status(ec_dev, &msg.cmd);
+	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1D2221569;
	Fri, 28 Mar 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169815; cv=none; b=F5TMBksl5Zj8fd6f2IC/2VWDw2a8Hx4dKdCJM9J04LZbrv/q4SBMlIdbhM+5jXxhVfc1beyNguc3Tfwok5ibD65d1CHEY/i1lcAFKIAvBgF6t+d8Vm+mkWnbRqT1w5bv7K2drT8Y8LMPWXGp5okrTqgD8NS2iifgIS283dRaibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169815; c=relaxed/simple;
	bh=wovA4Aud7DhDJdEaIv13byMvexafADunHResb3o9c/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p5D8QXpXhT9cYW7OAHVJKQe6ggsn3Nn7NoF/7TPqjtiwtVIvJ0NCUYr4DmPl5Ces0Wxt35sDeSXxkyoC1c4XpSoaEgy0I/7LggmqLMgTado+UcUKb0S3nY16BHmLK0egL+xBxivwRnff/RVYPxTdaLuHQmVKkvIp9HHNglEsGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQkOikoo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQkOikoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D95DC4CEE4;
	Fri, 28 Mar 2025 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743169814;
	bh=wovA4Aud7DhDJdEaIv13byMvexafADunHResb3o9c/I=;
	h=Date:From:To:Cc:Subject:From;
	b=SQkOikoocc5ajqf+GsC/NyT9N/He3BHYNnePbD4I3saofoYa6vu+uRMrEOknILRXE
	 CDKnDJJOeV60xZYg+YFGNItagokMk8Wub8p7DdmQoXtkYOqkfa+f/b/dr5yD5FaTYG
	 yDTLsSbcAz0CXAW/OOHs7EC1G0oKR1UMe2hxtaFfYBm9n21KHuOXgs0KA2fVdKzrxD
	 8TRaXn00sRjHNnIYzSDaH3PD4SYwKAaaiA1AJJ1pAOdn3OiSCXwtTvA7LmShxWwLGt
	 wh3zsMeSMgVkREcLDO/GWa9rU30fpppwXD2RQQTEJV4xyZfxI5HyKLbKPLJrEY1VMK
	 6+AfTIG5GBlvg==
Date: Fri, 28 Mar 2025 07:50:11 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] platform/chrome: cros_ec: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z-apE0ZmckBjRDyx@kspp>
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

So, with these changes, fix the following warning:

drivers/platform/chrome/cros_ec.c:106:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/platform/chrome/cros_ec.c | 47 +++++++++++++++++--------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 110771a8645e..cd15aa0cb082 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -99,51 +99,56 @@ irqreturn_t cros_ec_irq_thread(int irq, void *data)
 }
 EXPORT_SYMBOL(cros_ec_irq_thread);
 
+union cros_ec_sleep_data {
+	struct ec_params_host_sleep_event req0;
+	struct ec_params_host_sleep_event_v1 req1;
+	struct ec_response_host_sleep_event_v1 resp1;
+} __packed;
+
 static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 {
 	int ret;
-	struct {
-		struct cros_ec_command msg;
-		union {
-			struct ec_params_host_sleep_event req0;
-			struct ec_params_host_sleep_event_v1 req1;
-			struct ec_response_host_sleep_event_v1 resp1;
-		} u;
-	} __packed buf;
+	DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
+			sizeof(union cros_ec_sleep_data));
+	struct ec_params_host_sleep_event *req0 =
+			(struct ec_params_host_sleep_event *)msg->data;
+	struct ec_params_host_sleep_event_v1 *req1 =
+			(struct ec_params_host_sleep_event_v1 *)msg->data;
+	struct ec_response_host_sleep_event_v1 *resp1 =
+			(struct ec_response_host_sleep_event_v1 *)msg->data;
 
-	memset(&buf, 0, sizeof(buf));
 
 	if (ec_dev->host_sleep_v1) {
-		buf.u.req1.sleep_event = sleep_event;
-		buf.u.req1.suspend_params.sleep_timeout_ms =
+		req1->sleep_event = sleep_event;
+		req1->suspend_params.sleep_timeout_ms =
 				ec_dev->suspend_timeout_ms;
 
-		buf.msg.outsize = sizeof(buf.u.req1);
+		msg->outsize = sizeof(*req1);
 		if ((sleep_event == HOST_SLEEP_EVENT_S3_RESUME) ||
 		    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
-			buf.msg.insize = sizeof(buf.u.resp1);
+			msg->insize = sizeof(*resp1);
 
-		buf.msg.version = 1;
+		msg->version = 1;
 
 	} else {
-		buf.u.req0.sleep_event = sleep_event;
-		buf.msg.outsize = sizeof(buf.u.req0);
+		req0->sleep_event = sleep_event;
+		msg->outsize = sizeof(*req0);
 	}
 
-	buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
+	msg->command = EC_CMD_HOST_SLEEP_EVENT;
 
-	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
+	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
 	/* Report failure to transition to system wide suspend with a warning. */
 	if (ret >= 0 && ec_dev->host_sleep_v1 &&
 	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME ||
 	     sleep_event == HOST_SLEEP_EVENT_S3_RESUME)) {
 		ec_dev->last_resume_result =
-			buf.u.resp1.resume_response.sleep_transitions;
+			resp1->resume_response.sleep_transitions;
 
-		WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
+		WARN_ONCE(resp1->resume_response.sleep_transitions &
 			  EC_HOST_RESUME_SLEEP_TIMEOUT,
 			  "EC detected sleep transition timeout. Total sleep transitions: %d",
-			  buf.u.resp1.resume_response.sleep_transitions &
+			  resp1->resume_response.sleep_transitions &
 			  EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
 	}
 
-- 
2.43.0


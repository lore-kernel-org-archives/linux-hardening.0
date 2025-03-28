Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EF2F37;
	Fri, 28 Mar 2025 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743166819; cv=none; b=nqKdQimGIHSv1i+EPkiDXggC3OU03n7yKkvffptj8h0ZTbdjsdqKV4I4bD4aSsdF4z8UGiLwDZE0iteSHsEvNTaDlzj/4/mHPwuc2t6bwlUNhpDHwyIdObborGPkdoqMNwNQJ0SKiqrRPJ+tlLux4H0U8JHLR0VtlA+6kzGiSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743166819; c=relaxed/simple;
	bh=+Wp2n86SjMypBd/q2Xpm8OByrsTcdjUxmeMbmDjejKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jRrvMw4WPUujy17xJcPzfhwitNrk3ixM1BU1JoLsa66+aGJljxrEkhfpT0KzTsBdGupWn0pupP4kud6ttt5Fr2u8prp9QgpbE6/ESfAeLbTYvjQ0RvEnwMQ7IHWQJ2ITJ64zJXhJByhO2KulcGmX3nnHoGdtv+jt7PV3PY3h3S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVmaWdNG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVmaWdNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F02C4CEE5;
	Fri, 28 Mar 2025 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743166817;
	bh=+Wp2n86SjMypBd/q2Xpm8OByrsTcdjUxmeMbmDjejKA=;
	h=Date:From:To:Cc:Subject:From;
	b=cVmaWdNGzBt+DHsJ12cynn4l63wP9k9bT99CeUjiv+/qsOqu9fpwsa4OCI7TvmdyX
	 GcfP8V3HTqdD1eRWs1iBTOQP8NahsC8ibHW+LzGFERhPpXpw/MiY0whtCWzd69r5ry
	 6NPZMI66/nP730Oqve6TsCl3Yr+xeGt8eGlEpy5iwD2Zc9nikycUs+RRxo7ABZlwIB
	 7BRJS2ZQ7COrU2u+DuETf6r8gNpoZPzaKO7FuHkftgn3ummCPD6pE6zfs8DSDJZOqH
	 xfghiqbA3J5Ubl/cw6iUZ293EpQDpeOz1ZtTNwNQA8nKfyKSY+MddZqfGqNekA9PtX
	 IlAf/NYkU3JgA==
Date: Fri, 28 Mar 2025 07:00:15 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] platform/chrome: cros_ec_proto: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z-adX1BB30dcSJ7x@kspp>
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

drivers/platform/chrome/cros_ec_proto.c:143:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/platform/chrome/cros_ec_proto.c:761:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 877b107fee4b..586358fbf981 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -139,12 +139,10 @@ static int cros_ec_xfer_command(struct cros_ec_device *ec_dev, struct cros_ec_co
 
 static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *result)
 {
-	struct {
-		struct cros_ec_command msg;
-		struct ec_response_get_comms_status status;
-	} __packed buf;
-	struct cros_ec_command *msg = &buf.msg;
-	struct ec_response_get_comms_status *status = &buf.status;
+	DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
+			sizeof(struct ec_response_get_comms_status));
+	struct ec_response_get_comms_status *status =
+			(struct ec_response_get_comms_status *)msg->data;
 	int ret = 0, i;
 
 	msg->version = 0;
@@ -757,16 +755,13 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 
 static int get_next_event(struct cros_ec_device *ec_dev)
 {
-	struct {
-		struct cros_ec_command msg;
-		struct ec_response_get_next_event_v3 event;
-	} __packed buf;
-	struct cros_ec_command *msg = &buf.msg;
-	struct ec_response_get_next_event_v3 *event = &buf.event;
+	DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
+			sizeof(struct ec_response_get_next_event_v3));
+	struct ec_response_get_next_event_v3 *event =
+			(struct ec_response_get_next_event_v3 *)msg->data;
 	int cmd_version = ec_dev->mkbp_event_supported - 1;
 	u32 size;
 
-	memset(msg, 0, sizeof(*msg));
 	if (ec_dev->suspended) {
 		dev_dbg(ec_dev->dev, "Device suspended.\n");
 		return -EHOSTDOWN;
-- 
2.43.0


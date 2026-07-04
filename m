Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E3372B27;
	Sat,  4 Jul 2026 03:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783136955; cv=none; b=o2XhQQ6zQgVj5JdviMjacw6SFXdblMGh1uNERpjgAwWZzQ/87TPnaGok04PT+VoM3ulpU8vLMYp1GGg66dsEHZaXCJmVPYRvvDRgIHnsfatCOUa4dC3yqAD2AJZaEqMrCBKtuiSpb+JfIH2G2pYpz2W91uPexUFVpheBm+Zm7YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783136955; c=relaxed/simple;
	bh=TFjQbWyzAMxvKwNbnP4LPBome1ljwijs1AcHQbPY+JY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uWu5WrH/IV14RYicx/1/3paQF4uQUEKIAaK/Fzaby1AQOKZiHv4oombYnjlgn66G8rEp/ZXDDPNEQKofSoLh93Jo9RJg12+va70wjRmegRtLJ5TxorjSY1xpDbMAYNVSwhkwb51V1tVE7D/IVHSVpuh82LKJyyjnTOEWzyfl3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=cFYJ/gs0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NFguQlYX; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="cFYJ/gs0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NFguQlYX"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id B7CD31300346;
	Fri,  3 Jul 2026 23:49:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 03 Jul 2026 23:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1783136951; x=1783140551; bh=jnB0rrYn5mUvHmZaVe+grQm+cXzwfP+A
	6jxeO42NYT4=; b=cFYJ/gs08qFzAnN03zhzf8lHC9u6XVaD7hOGSEhoWn4SyZRf
	yImUouOYPWtTpKfUiZ0vzFYSzvt2NW6+3hC162pdAydia/R8JZfGe01AsAYU2nd5
	qAAfPRBWak8FbRniTTTXTX3N+nsWCWsoOqLg8ywyaOCRkggaEJxnkzlPBd381sTb
	ibauz/UFD4VFBVHwklSEKXOMg0FJ9BjtAU4EGtxUa+UuOMYdbrzmrM8EvhJJLe7X
	zt3mPs/8Oscz/0GWvJ+zLU3OQUwxylxDiGhLWjYy56M0KbqsqIy/xu/TfjeMO80x
	wvK1sxKyVo7WujuAdzWKsb6oURoL10LYPfmuYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783136951; x=
	1783140551; bh=jnB0rrYn5mUvHmZaVe+grQm+cXzwfP+A6jxeO42NYT4=; b=N
	FguQlYXZcwJalNytBcM/7oKA554ATa9pJNRu+VloSFtW9rf3ZmNmHXULrDh575wG
	nZ2NtiTxMWlEh5uJUL2SKpIn6MEwI4iX7OFrzM4ETZpfBk5SFq/Vk4ujrqlGY3Py
	4hKKdvIEDJVtEqVEikwij2VoSEErs+K8+mHsWkWtUcaAdfuDtRp9Nl59za0AtQ7Q
	76Xi4yNf9kzw8cUoQgk6L8zh9zinPfljAWL/jtouczL+iy50yPA8ol7UH6CnVu8m
	Gg2uqPOmoq2+9Hep7kWJRIt4e73Q+6qvzT7++p4WvMdk2A1BwTU5hpPEpIxGLB3u
	l+yeBPPY9v0eavk1owIIQ==
X-ME-Sender: <xms:toJIalMSfUibPoJzysy-7_w3tkaGwKgYvicchOotFFiE8aVS2EVerg>
    <xme:toJIaoYV3St34wcBatPVZm2m-ZeI4Dk8mvkGlHCZPEqqB97oa_lEU_4duEse2oT7v
    CZ-H3wvKUY-NA3Ogh1p1NKKYA9Y3U3rkQZRks7RMRy36fC614HhliQ>
X-ME-Received: <xmr:toJIak-KByOFbIzU5qgJJ8ryymovCjErn3DJa73rwKHpyGx_OyW4N76lErg>
X-ME-Proxy-Cause: dmFkZTE1RLNBESqud5IguXj7/320U/Hq5bUFrR0Cl8gmtcPFAstBi1qVUiCwERepb4Y5H/
    +AueLB/rBNEbeIXMrek2vZdfXG13T2L9ww075AZAxwR248H/VVyySljgycYsKcxCq5gobT
    HYZhFQta2WT9ZHmGMb90K8gV2hwvSp5yTQfA3bxaJE3arrYvxz0yacC/q9bmt9t3ge47aQ
    WJco6X38hD5UgAdeGOKvHclcHvC1+r3sX1nileT9M8gIy1q7lCw6z1zVDWf6DlDyy21KKU
    lXHTWmXrecqFDhiKREu5ptUV3OBPs0oCd4e6thX/W/mRKfl/QiOuI8JsMAde7dHDTrcytG
    tRqJ/WTutim5EaJr+sWtoix6Zj5/Qd2buJ66+X+8teMwBUMDVdJSw3WAZoLi1X8TWQ8zU9
    aEByZmsurYV/8hPOK6mKZmwBIpb6ysgosE0nN0WNb/dgUL03rwsifAue/wdudQdTBKcIY/
    iPeImB6wJ7tgF7Sb7nKiRzIbL/KG4J22MH6aoS9MLGV9id7I/Cn6pQ5i5D+Wt5NMzQEcAD
    1HxN/5EIHBS7/7Nnt1i+Fc+rMFbiRRpE92dvFom5A6O/SKSzTdz3IXlG+ziM/3JsMp9Iy4
    l4anNeonj9M3Cm7erGpUY6914Wy3ssmHI46oWJMNw1kWRgZ5n2K5T/Pv5xPw
X-ME-Proxy: <xmx:toJIapTEGCtHPmA18Syzsqw39iK2P-JAxEkfb5YLST-a1KicaPUQUQ>
    <xmx:toJIaufjPp7jDOT0cnfSrUBSGhDJOXhYxA-Z_y_Bd4kYTNspQtH4xg>
    <xmx:toJIarSU8XzUCaeTxCH1xYaStWWwKKX5YGerTxkywgG8IpyQzqvieA>
    <xmx:toJIaqLgg8hawmezWth0uZDdCtcnRiHNJwU14ZeZzib_DQLV4t9gqw>
    <xmx:t4JIajmkERby9x6hzupmMKWURlRgQIrdXH3CMnTidKGZa9Kgfr89-Apv>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 23:49:10 -0400 (EDT)
Date: Fri, 3 Jul 2026 22:49:08 -0500
From: Ian Bridges <icb@fastmail.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next] devlink: Replace strlcat() with seq_buf
Message-ID: <akiCtALVjd9TF8Xl@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In preparation for removing the strlcat() API[1], replace its uses in
__devlink_compat_running_version().

The function accumulates a variable number of version strings into a
fixed buffer, which is what seq_buf is for. The seq_buf is anchored at
the end of any existing string in the buffer and each version string
is appended with a single seq_buf_printf(). The output is unchanged,
including under truncation.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
The patch was tested as follows, on top of net-next:
 - x86_64 allmodconfig and allyesconfig builds of net/devlink/dev.o at
   W=1 produce no warnings.
 - A userspace comparison of the old and new construction ran with
   randomized version lists and buffer contents across all buffer
   fill levels. The outputs are byte-identical in every case,
   including on overflow.
 - The changed path was exercised in a QEMU guest through the ethtool
   GDRVINFO ioctl against a netdevsim device, before and after the
   change, with identical fw_version output.

 net/devlink/dev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 57b2b8f03543..0d4301267171 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/seq_buf.h>
 #include <net/genetlink.h>
 #include <net/sock.h>
 #include "devl_internal.h"
@@ -1188,8 +1189,10 @@ static void __devlink_compat_running_version(struct devlink *devlink,
 					     char *buf, size_t len)
 {
 	struct devlink_info_req req = {};
+	size_t used = strnlen(buf, len);
 	const struct nlattr *nlattr;
 	struct sk_buff *msg;
+	struct seq_buf sb;
 	int rem, err;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -1201,6 +1204,8 @@ static void __devlink_compat_running_version(struct devlink *devlink,
 	if (err)
 		goto free_msg;
 
+	seq_buf_init(&sb, buf + used, len - used);
+
 	nla_for_each_attr_type(nlattr, DEVLINK_ATTR_INFO_VERSION_RUNNING,
 			       (void *)msg->data, msg->len, rem) {
 		const struct nlattr *kv;
@@ -1208,8 +1213,8 @@ static void __devlink_compat_running_version(struct devlink *devlink,
 
 		nla_for_each_nested_type(kv, DEVLINK_ATTR_INFO_VERSION_VALUE,
 					 nlattr, rem_kv) {
-			strlcat(buf, nla_data(kv), len);
-			strlcat(buf, " ", len);
+			seq_buf_printf(&sb, "%s ",
+				       (const char *)nla_data(kv));
 		}
 	}
 free_msg:
-- 
2.47.3


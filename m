Return-Path: <SRS0=j6/H=DX=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48406C433DF
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 13:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E4A207C4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 13:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="Q7wohjMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407875AbgJPNCC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407873AbgJPNCC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Oct 2020 09:02:02 -0400
Received: from confino.investici.org (confino.investici.org [IPv6:2a00:c38:11e:ffff::a020])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF755C0613D3
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 06:02:01 -0700 (PDT)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CCQzx290Sz15VL;
        Fri, 16 Oct 2020 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1602852781;
        bh=FnQjvd7oOqdEnkCkZpL3pl3LgLr8dYOhcR6brW1rROU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7wohjMjpYHoVEb7rznA4zBLIFyb6FMWaYjM0wNljNvdBTeyfinmpbgFVNxB5bWlk
         qIA+K5L4tcAK7XEZSObUYznFsrk6Ymu3HFKUxYUK7hqDIXwczWrreq/EoumTzRYbVB
         GZr0GqPlgBDdk5XMp0fnVMCxsRRY1Io0+INgOJao=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CCQzx1DTkz15VK;
        Fri, 16 Oct 2020 12:53:01 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [PATCH v1 2/3] Modify return value of nla_strlcpy to match that of strscpy.
Date:   Fri, 16 Oct 2020 14:52:15 +0200
Message-Id: <20201016125216.10922-3-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

This patch solves part 2 of issue: https://github.com/KSPP/linux/issues/110

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 include/net/netlink.h |  2 +-
 include/net/pkt_cls.h |  3 ++-
 lib/nlattr.c          | 31 ++++++++++++++++++++-----------
 net/sched/act_api.c   |  2 +-
 net/sched/sch_api.c   |  2 +-
 5 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 7356f41d23ba..446ca182e13d 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -506,7 +506,7 @@ int __nla_parse(struct nlattr **tb, int maxtype, const struct nlattr *head,
 		struct netlink_ext_ack *extack);
 int nla_policy_len(const struct nla_policy *, int);
 struct nlattr *nla_find(const struct nlattr *head, int len, int attrtype);
-size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize);
+ssize_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize);
 char *nla_strdup(const struct nlattr *nla, gfp_t flags);
 int nla_memcpy(void *dest, const struct nlattr *src, int count);
 int nla_memcmp(const struct nlattr *nla, const void *data, size_t size);
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index d4d461236351..f42db07c399b 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -4,6 +4,7 @@
 
 #include <linux/pkt_cls.h>
 #include <linux/workqueue.h>
+#include <linux/errno.h>
 #include <net/sch_generic.h>
 #include <net/act_api.h>
 #include <net/net_namespace.h>
@@ -512,7 +513,7 @@ tcf_change_indev(struct net *net, struct nlattr *indev_tlv,
 	char indev[IFNAMSIZ];
 	struct net_device *dev;
 
-	if (nla_strlcpy(indev, indev_tlv, IFNAMSIZ) >= IFNAMSIZ) {
+	if (nla_strlcpy(indev, indev_tlv, IFNAMSIZ) == -E2BIG) {
 		NL_SET_ERR_MSG_ATTR(extack, indev_tlv,
 				    "Interface name too long");
 		return -EINVAL;
diff --git a/lib/nlattr.c b/lib/nlattr.c
index ab96a5f4b9b8..83dd233bbe3e 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -713,29 +713,38 @@ EXPORT_SYMBOL(nla_find);
  * @dst: where to copy the string to
  * @nla: attribute to copy the string from
  * @dstsize: size of destination buffer
+ * @returns: -E2BIG if @dstsize is 0 or source buffer length greater than
+ * @dstsize, otherwise it returns the number of copied characters (not
+ * including the trailing %NUL).
  *
  * Copies at most dstsize - 1 bytes into the destination buffer.
- * The result is always a valid NUL-terminated string. Unlike
- * strlcpy the destination buffer is always padded out.
- *
- * Returns the length of the source buffer.
+ * The result is always a valid NUL-terminated string.
  */
-size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
+ssize_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
 {
+	size_t len;
+	ssize_t ret;
 	size_t srclen = nla_len(nla);
 	char *src = nla_data(nla);
 
+	if (dstsize == 0 || WARN_ON_ONCE(dstsize > INT_MAX))
+		return -E2BIG;
+
 	if (srclen > 0 && src[srclen - 1] == '\0')
 		srclen--;
 
-	if (dstsize > 0) {
-		size_t len = (srclen >= dstsize) ? dstsize - 1 : srclen;
-
-		memcpy(dst, src, len);
-		dst[len] = '\0';
+	if (srclen >= dstsize) {
+		len = dstsize - 1;
+		ret = -E2BIG;
+	} else {
+		len = srclen;
+		ret = len;
 	}
 
-	return srclen;
+	memcpy(dst, src, len);
+	dst[len] = '\0';
+
+	return ret;
 }
 EXPORT_SYMBOL(nla_strlcpy);
 
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index f66417d5d2c3..ed411d6c29fc 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -935,7 +935,7 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 			NL_SET_ERR_MSG(extack, "TC action kind must be specified");
 			goto err_out;
 		}
-		if (nla_strlcpy(act_name, kind, IFNAMSIZ) >= IFNAMSIZ) {
+		if (nla_strlcpy(act_name, kind, IFNAMSIZ) == -E2BIG) {
 			NL_SET_ERR_MSG(extack, "TC action name too long");
 			goto err_out;
 		}
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 2a76a2f5ed88..3e89c666d1e8 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1170,7 +1170,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 #ifdef CONFIG_MODULES
 	if (ops == NULL && kind != NULL) {
 		char name[IFNAMSIZ];
-		if (nla_strlcpy(name, kind, IFNAMSIZ) < IFNAMSIZ) {
+		if (nla_strlcpy(name, kind, IFNAMSIZ) != -E2BIG) {
 			/* We dropped the RTNL semaphore in order to
 			 * perform the module load.  So, even if we
 			 * succeeded in loading the module we have to
-- 
2.20.1


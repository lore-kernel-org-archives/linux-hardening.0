Return-Path: <SRS0=m/Ru=D2=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8981CC433DF
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 15:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B8222363
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 15:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="XeovV63H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgJSPYJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Oct 2020 11:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbgJSPYJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Oct 2020 11:24:09 -0400
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F01C0613CE
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2020 08:24:09 -0700 (PDT)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CFLBw3lwlz8sgm;
        Mon, 19 Oct 2020 15:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603121048;
        bh=ktqeYGD6Jj57KeHxmdEyHWyBzvKRQnrorqJ1zCrueoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XeovV63HtSVakuejvJCKJI9NjR3C7QhadF5nSB4w8lLapEXGvVT/uDbu2q8O0WPcR
         yaGTwv6MoSxxXaDbOHGtSAgHql6O9HEg3FwucWexIX6LSufWE/P7Ka9qQnwJi0ylZx
         HLb9Axv/GbzSZaRb1bgird8EGORXC8KKuu+D1V7k=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CFLBw0s4mz8sgM;
        Mon, 19 Oct 2020 15:24:07 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org
Cc:     kuba@kernel.org, davem@davemloft.net,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [RFC][PATCH v2 2/3] Modify return value of nla_strlcpy to match that of strscpy.
Date:   Mon, 19 Oct 2020 17:23:30 +0200
Message-Id: <20201019152331.20583-3-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201019152331.20583-1-laniel_francis@privacyrequired.com>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
 <20201019152331.20583-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

nla_strlcpy now returns -E2BIG if src was truncated when written to dst.
It also returns this error value if dstsize is 0 or higher than INT_MAX.

For example, if src is "foo\0" and dst is 3 bytes long, the result will be:
1. "foG" after memcpy (G means garbage).
2. "fo\0" after memset.
3. -E2BIG is returned because src was not completely written into dst.

The callers of nla_strlcpy were modified to take into account this modification.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 include/net/netlink.h |  2 +-
 include/net/pkt_cls.h |  3 ++-
 lib/nlattr.c          | 33 +++++++++++++++++++++------------
 net/sched/act_api.c   |  2 +-
 net/sched/cls_api.c   |  2 +-
 net/sched/sch_api.c   |  2 +-
 6 files changed, 27 insertions(+), 17 deletions(-)

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
index d4d461236351..85f4ac779399 100644
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
+	if (nla_strlcpy(indev, indev_tlv, IFNAMSIZ) < 0) {
 		NL_SET_ERR_MSG_ATTR(extack, indev_tlv,
 				    "Interface name too long");
 		return -EINVAL;
diff --git a/lib/nlattr.c b/lib/nlattr.c
index 07156e581997..d692716bda78 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -713,30 +713,39 @@ EXPORT_SYMBOL(nla_find);
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
+ * Unlike strlcpy the destination buffer is always padded out.
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
-		/* Zero pad end of dst. */
-		memset(dst + len, 0, dstsize - len);
+	if (srclen >= dstsize) {
+		len = dstsize - 1;
+		ret = -E2BIG;
+	} else {
+		len = srclen;
+		ret = len;
 	}
 
-	return srclen;
+	memcpy(dst, src, len);
+	/* Zero pad end of dst. */
+	memset(dst + len, 0, dstsize - len);
+
+	return ret;
 }
 EXPORT_SYMBOL(nla_strlcpy);
 
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index f66417d5d2c3..541574520c52 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -935,7 +935,7 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 			NL_SET_ERR_MSG(extack, "TC action kind must be specified");
 			goto err_out;
 		}
-		if (nla_strlcpy(act_name, kind, IFNAMSIZ) >= IFNAMSIZ) {
+		if (nla_strlcpy(act_name, kind, IFNAMSIZ) < 0) {
 			NL_SET_ERR_MSG(extack, "TC action name too long");
 			goto err_out;
 		}
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 41a55c6cbeb8..f0bf64393cbf 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -223,7 +223,7 @@ static inline u32 tcf_auto_prio(struct tcf_proto *tp)
 static bool tcf_proto_check_kind(struct nlattr *kind, char *name)
 {
 	if (kind)
-		return nla_strlcpy(name, kind, IFNAMSIZ) >= IFNAMSIZ;
+		return nla_strlcpy(name, kind, IFNAMSIZ) > 0;
 	memset(name, 0, IFNAMSIZ);
 	return false;
 }
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 2a76a2f5ed88..f9b053b30a7b 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1170,7 +1170,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 #ifdef CONFIG_MODULES
 	if (ops == NULL && kind != NULL) {
 		char name[IFNAMSIZ];
-		if (nla_strlcpy(name, kind, IFNAMSIZ) < IFNAMSIZ) {
+		if (nla_strlcpy(name, kind, IFNAMSIZ) > 0) {
 			/* We dropped the RTNL semaphore in order to
 			 * perform the module load.  So, even if we
 			 * succeeded in loading the module we have to
-- 
2.20.1


Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0BAC43217
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Feb 2022 02:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiBJCxZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:53:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiBJCxX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Feb 2022 21:53:23 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA26240B6
        for <linux-hardening@vger.kernel.org>; Wed,  9 Feb 2022 18:53:25 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 9so4877294pfx.12
        for <linux-hardening@vger.kernel.org>; Wed, 09 Feb 2022 18:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rl83JHro1anRWjIQgDE0XbmJ8BuE/Ygl74q80wpYn4M=;
        b=FVy5gybG75QthWoOFg6lXY1vKAIo4Qk48eB/T/aIoERC7xTr0zQeWQS7qc+Ih0KsBH
         eZwLfoZl8SQ6qzXgsauNDHBkrpUJKn7A0FHGJutz1wwJNZhDOH12vBLB9LPw9Jz9EMpd
         xP7EBQyvMSHD+pkh2/4WWL2eSXB35ow8+bC7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rl83JHro1anRWjIQgDE0XbmJ8BuE/Ygl74q80wpYn4M=;
        b=Tl2najNu+eAB6CqcpWyt7ZdAbRkMMIRgfRyu04pbHeDDXx3G21RnL9M+FpXQH2jCmf
         9WyGGa1nbLyXUHRdAEh81NRq/N8t0OfyDCh+Uq7dqe1zU2WNYZHd9WTz1zyp+a/ohtmW
         KY4aCLccOxOpiYYLtP2bFTg8CyphptF7rvV5M83MUQIgSgGBSVCz1GwmPlt1kwxP3G1W
         kicyUmEzGOTvVCRyW1RnCqBYYBD4BhlPNL8OQrgupmQhZLdrFToReSoxvYP10t6zJplU
         ObCF5WmEsIu5WFdCy6UqkHRHuOAYRO9SU0SMr/7hfrJSVmGKJJUCVo7X/7R+saV2Nahb
         6EMA==
X-Gm-Message-State: AOAM531PTQAJMCI4qXwT8HY7GQFXv2jPDZ+m9RyjwBpIQ97XYvbmPcXX
        nnWfiNTx3xpT6L1hca+axrVtjw==
X-Google-Smtp-Source: ABdhPJw+gp51DO3UuC2Vk5guTVJ5d67yx58qd2qO9c9t1jcZL1HCjXXoQ1JcC5e6J/o2t4J/lPI5ZA==
X-Received: by 2002:a63:9307:: with SMTP id b7mr4499370pge.616.1644461604498;
        Wed, 09 Feb 2022 18:53:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t24sm21549660pfg.92.2022.02.09.18.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 18:53:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Robert=20=C5=9Awi=C4=99cki?= <robert@swiecki.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] samples/seccomp: Adjust sample to also provide kill option
Date:   Wed,  9 Feb 2022 18:53:21 -0800
Message-Id: <20220210025321.787113-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220210025321.787113-1-keescook@chromium.org>
References: <20220210025321.787113-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611; h=from:subject; bh=CDt8AGWhLzy7NL4kvvBB5tTCY0LueyR3ecDeoGuIsbA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiBH4h69+BYJGJ3Tocnvvj73dk+HxAJPLEUEd/PKa8 VwJ6tq2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgR+IQAKCRCJcvTf3G3AJjdOD/ oDc+BTzQ15+vRXjOZrhBIBubYZ54o/oFqBiaqcBS7fVKBRJnI49NttnvRr0tq5MKRb0iNpHL3xMkxk GFX9TWlxpEUn+SN1tpQ258maPyQT8GNoGtciu9zuF04vllZcN+ptH5T3qwpn2GAmM2l0g0Vkak7OF5 MZpoq0WeiyCksDYAee8PMvm0prsUZXTK09MwRtIRnoQu1wK5FzP5d75SvGqsqvz3wY/BChveCjfS3l VpyZS4z0+9DAzl8mcIprS+r0B/jssYOMf5hEp0GHtFSyAypeVxhBmQXZ/p2CWHZ9iO1i4612MrdZHd KtAhE3KFY7NDp+FrxE8wB5u0fPm37VgZpliIsqDyo8yzolv3K67bXRQjxmUaPlYROqicxECfx5T7mV FjCCPmU+RqAZ1fxfUWUfPIk4LrUABcJrkPESZuEvyN5JVGdor6AbxOb1Nq4KcjEeVWEFWV7EyjvOoa NvplB4ov4uWSmIbvfkC5z9tFrKXBRTAklxBoHfZaYqGO7/sRpexsQiNW6wsLQ7hAJer6E1hoh48t4a XTfdGou6FMR5mNWu0ossHE4tRxATv4D3UfqAaFRaGOEUCDyVldBKTxAiB3mTi1xnCXQKb8xjYvZ0ew 7tJxLr7npTMcGlCEkDsMHq1A3FUPtn4PUnqpPPealHSKdpL2NfYlk1rtNqrA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As a quick way to test SECCOMP_RET_KILL, have a negative errno mean to
kill the process.

While we're in here, also swap the arch and syscall arguments so they're
ordered more like how seccomp filters order them.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 samples/seccomp/dropper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/samples/seccomp/dropper.c b/samples/seccomp/dropper.c
index cc0648eb389e..4bca4b70f665 100644
--- a/samples/seccomp/dropper.c
+++ b/samples/seccomp/dropper.c
@@ -25,7 +25,7 @@
 #include <sys/prctl.h>
 #include <unistd.h>
 
-static int install_filter(int nr, int arch, int error)
+static int install_filter(int arch, int nr, int error)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD+BPF_W+BPF_ABS,
@@ -42,6 +42,10 @@ static int install_filter(int nr, int arch, int error)
 		.len = (unsigned short)(sizeof(filter)/sizeof(filter[0])),
 		.filter = filter,
 	};
+	if (error == -1) {
+		struct sock_filter kill = BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_KILL);
+		filter[4] = kill;
+	}
 	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
 		perror("prctl(NO_NEW_PRIVS)");
 		return 1;
@@ -57,9 +61,10 @@ int main(int argc, char **argv)
 {
 	if (argc < 5) {
 		fprintf(stderr, "Usage:\n"
-			"dropper <syscall_nr> <arch> <errno> <prog> [<args>]\n"
+			"dropper <arch> <syscall_nr> <errno> <prog> [<args>]\n"
 			"Hint:	AUDIT_ARCH_I386: 0x%X\n"
 			"	AUDIT_ARCH_X86_64: 0x%X\n"
+			"	errno == -1 means SECCOMP_RET_KILL\n"
 			"\n", AUDIT_ARCH_I386, AUDIT_ARCH_X86_64);
 		return 1;
 	}
-- 
2.30.2


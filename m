Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5E5C432BE
	for <linux-hardening@archiver.kernel.org>; Wed,  1 Sep 2021 23:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BD961026
	for <linux-hardening@archiver.kernel.org>; Wed,  1 Sep 2021 23:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbhIAXoR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 1 Sep 2021 19:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244401AbhIAXoP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 1 Sep 2021 19:44:15 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F23C061757
        for <linux-hardening@vger.kernel.org>; Wed,  1 Sep 2021 16:43:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s29so190914pfw.5
        for <linux-hardening@vger.kernel.org>; Wed, 01 Sep 2021 16:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SKq9FaM29beTFKHBuFsUutnwIAeKxNVhRiqi1gUUfqk=;
        b=PzmK/+NUhZxG8Z+YuxmTpJb9O380IFK7e1wlHLXqZCa1XFyxfVnhpezGuyhZ1kjAoF
         xxjSBwVxaM4uxKEzPeHweqkiVLEtiyo0Zt0xhddivh38U2sDftCITySNaIEc1dqIurxM
         0TWMp/bKIm8hlLJykPTkJVGON+3mdvfQ8/p84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SKq9FaM29beTFKHBuFsUutnwIAeKxNVhRiqi1gUUfqk=;
        b=pRcDatA5AqawRFAQ+gbuPHFenZxU/uncrA/eM/X2h5547gIkpk93C5EVzL2/BwtsQk
         TJc0oVpnzQvRohCVrFXK+dv+BTvVY74p+Oz3uOuvTz7x2kFKZBaZhhRB4mPpuhJdngSW
         Nw+OsCic+QNPbGWpBf57s+O31Cl6HqPF89fHDTiPvlx7WCDz2h4oFMcLX8dtjnxDobfr
         Vr25YcJLPRc8Lpcw3BTQ1FXkjetx93UBs1/M23PdG6+L5bERjfhtkLsolw7VxSsPsfML
         I520eAl6XEtyTWSIekCdext4yjAtbBza9WjdNZ4Z/6Dfn/YJmDYoFmlD1Z51jINGv9BF
         7SfQ==
X-Gm-Message-State: AOAM533Z1c+86ctVHxhSsr6KmoAtM1vAbxhpd4RW7YrVJlwT8ITKAU+c
        Ry9a+ItlI6ecC/yf6dHtTUajkw==
X-Google-Smtp-Source: ABdhPJyKvnT+zbVm+OyNSiV0tbk4E8w3SgYbGSl4SqDh2XVYSBz4FJsZZOYUbxtYJOwjDXefvJQ2VQ==
X-Received: by 2002:a05:6a00:230e:b029:3c4:24ff:969d with SMTP id h14-20020a056a00230eb02903c424ff969dmr380233pfh.44.1630539797625;
        Wed, 01 Sep 2021 16:43:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n24sm37653pgv.60.2021.09.01.16.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:43:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] binfmt_elf: Reintroduce using MAP_FIXED_NOREPLACE
Date:   Wed,  1 Sep 2021 16:43:14 -0700
Message-Id: <20210901234314.2624109-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4227; h=from:subject; bh=mwvE/gDRs6e5NxW4p+Kk0QNaEgjqTD4VySLc2KZdvDw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhMBARowTodGVt/9YDPs4IjC58d4M0IDDsGnVkzR3B foKFAPqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTAQEQAKCRCJcvTf3G3AJluIEA Cd38ESBXKwortzq1h4eaJNKXI+JZlB8Ihl3WB4vg7A+ecCnsG2ZOz1BJAZhCsIHQ4wfKFylECGxLoO V2adQU117i+u6jhbZMMoL3hMRYQpPEe684WeiBrHhFRvt0epxz9T1SGWWYkyqEB9mnptqUbFI+VPQ1 wTMc++ZzZMufUt2AG17s+0gRSXiyznVoCZiZKtnvVOaAQy2XKjmrq7lEIxcp2UUxLlKzzWFZJuseby Fzln0RbCW3aKjqTTHwTv/8rt5ENbFwsOI3jf5J5rFqXhyYA2lzzlVvDYvcR/U8N2EOfExj9fKWgm/s I803h1/1F4j9/VNdZW+36lQMRsOKOuP88ogB+1+JxirbW0jaORfgWcZqhdkPNBDQ9IeheOrSb+rqWC d6cr12+FbjtuZ1RQqx1c0Ad0izk1d6tWVA2kWDNq0IGVqjeyl0H4oPz6uMwD4uifcM3QX6xEZCtJVJ PIL21XXJoCeg2wvt7hx6ni/hgKinu2/6/6UVCofRNtdwBEd2LRtp3cpz0Jx1qJFgFURztowHKjsj63 +OHMxAuVxTEznUewjivihW34ePYJeDtRQ6QbbPv0FgtwlJBoVfldEfKVHxnRHC8ZbRZL6y+XYeiXM2 31zO61UhfXd3LtZzgI7344SkvMkk3FG5+EYRMlJ+uLTk0mv0IF+Mk50hDPuw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Commit b212921b13bd ("elf: don't use MAP_FIXED_NOREPLACE for elf
executable mappings") reverted back to using MAP_FIXED to map ELF
LOAD segments because it was found that the segments in some binaries
overlap and can cause MAP_FIXED_NOREPLACE to fail. The original intent of
MAP_FIXED_NOREPLACE was to prevent the silent clobbering of an existing
mapping (e.g. stack) by the ELF image. To achieve this, expand on the
logic used when loading ET_DYN binaries which calculates a total size
for the image when the first segment is mapped, maps the entire image,
and then unmaps the remainder before remaining segments are mapped.
Apply this to ET_EXEC binaries as well as ET_DYN binaries as is done
now, and for both ET_EXEC and ET_DYN+INTERP use MAP_FIXED_NOREPLACE for
the initial total size mapping and MAP_FIXED for remaining mappings.
For ET_DYN w/out INTERP, continue to map at a system-selected address
in the mmap region.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Co-developed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Link: https://lore.kernel.org/lkml/1595869887-23307-2-git-send-email-anthony.yznaga@oracle.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 439ed81e755a..ef00bf8bd6f4 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1074,20 +1074,26 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		vaddr = elf_ppnt->p_vaddr;
 		/*
-		 * If we are loading ET_EXEC or we have already performed
-		 * the ET_DYN load_addr calculations, proceed normally.
+		 * The first time through the loop, load_addr_set is false:
+		 * layout will be calculated. Once set, use MAP_FIXED since
+		 * we know we've already safely mapped the entire region with
+		 * MAP_FIXED_NOREPLACE in the once-per-binary logic following.
 		 */
-		if (elf_ex->e_type == ET_EXEC || load_addr_set) {
+		if (load_addr_set) {
 			elf_flags |= MAP_FIXED;
+		} else if (elf_ex->e_type == ET_EXEC) {
+			/*
+			 * This logic is run once for the first LOAD Program
+			 * Header for ET_EXEC binaries. No special handling
+			 * is needed.
+			 */
+			elf_flags |= MAP_FIXED_NOREPLACE;
 		} else if (elf_ex->e_type == ET_DYN) {
 			/*
 			 * This logic is run once for the first LOAD Program
 			 * Header for ET_DYN binaries to calculate the
 			 * randomization (load_bias) for all the LOAD
-			 * Program Headers, and to calculate the entire
-			 * size of the ELF mapping (total_size). (Note that
-			 * load_addr_set is set to true later once the
-			 * initial mapping is performed.)
+			 * Program Headers.
 			 *
 			 * There are effectively two types of ET_DYN
 			 * binaries: programs (i.e. PIE: ET_DYN with INTERP)
@@ -1108,7 +1114,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * Therefore, programs are loaded offset from
 			 * ELF_ET_DYN_BASE and loaders are loaded into the
 			 * independently randomized mmap region (0 load_bias
-			 * without MAP_FIXED).
+			 * without MAP_FIXED nor MAP_FIXED_NOREPLACE).
 			 */
 			if (interpreter) {
 				load_bias = ELF_ET_DYN_BASE;
@@ -1117,7 +1123,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
 				if (alignment)
 					load_bias &= ~(alignment - 1);
-				elf_flags |= MAP_FIXED;
+				elf_flags |= MAP_FIXED_NOREPLACE;
 			} else
 				load_bias = 0;
 
@@ -1129,7 +1135,14 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * is then page aligned.
 			 */
 			load_bias = ELF_PAGESTART(load_bias - vaddr);
+		}
 
+		/*
+		 * Calculate the entire size of the ELF mapping (total_size).
+		 * (Note that load_addr_set is set to true later once the
+		 * initial mapping is performed.)
+		 */
+		if (!load_addr_set) {
 			total_size = total_mapping_size(elf_phdata,
 							elf_ex->e_phnum);
 			if (!total_size) {
-- 
2.30.2


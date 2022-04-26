Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68093C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Apr 2022 06:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiDZGO4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Apr 2022 02:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245070AbiDZGOy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Apr 2022 02:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FEA36140;
        Mon, 25 Apr 2022 23:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3803B61300;
        Tue, 26 Apr 2022 06:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB566C385A0;
        Tue, 26 Apr 2022 06:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650953506;
        bh=4AtGfUOOD7eSeXBmH+CWZwnEA9Plcz+reR06sgMw9ao=;
        h=Date:From:To:Cc:Subject:From;
        b=oqKVBQHa38u+k5V/hkVv1rWq/L+s5zTOQ99ZMyK0aSgRILWjIu1BPkushPZR95NAW
         2fEfCPq7z9hD/rdjXvr1tjfFVoJ7j7/hyd/9XYtmkK8WUVEMkIkl5KobrBbWffuNPe
         nTKSIV/2p+PvNpROLjsJ/phM42xqd8L598FQTN1D+Izo6r9Cu7R8rTXx+bsz210MUy
         fsxGEX9Z4UST37L0MSi0/hz/4ULd3E0uOeBxstgbOuj9JgmUBDMw9qgARUQNDOZoXh
         cK9ejjiS0eKDB1qxI2BHvPh+X3QplyTaWABjB5bZRC7yRcig+DYQBj1HK3P97OeOE4
         TuIzSh7cvgWng==
Date:   Tue, 26 Apr 2022 01:20:43 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] checkpatch: add new alloc functions to alloc with
 multiplies check
Message-ID: <20220426062043.GA19970@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

kvmalloc() and kvzalloc() functions have now 2-factor multiplication
argument forms kvmalloc_array() and kvcalloc(), correspondingly.

Add alloc-with-multiplies checks for these new functions.

Link: https://github.com/KSPP/linux/issues/187
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 scripts/checkpatch.pl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 577e02998701..503e8abbb2c1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7033,14 +7033,16 @@ sub process {
 			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
 		}
 
-# check for k[mz]alloc with multiplies that could be kmalloc_array/kcalloc
+# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
 		if ($perl_version_ok &&
 		    defined $stat &&
-		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*(k[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
+		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
 			my $oldfunc = $3;
 			my $a1 = $4;
 			my $a2 = $10;
 			my $newfunc = "kmalloc_array";
+			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
+			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
 			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
 			my $r1 = $a1;
 			my $r2 = $a2;
@@ -7057,7 +7059,7 @@ sub process {
 					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
 				    $cnt == 1 &&
 				    $fix) {
-					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*(k[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
+					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
 				}
 			}
 		}
-- 
2.27.0


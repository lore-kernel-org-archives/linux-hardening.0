Received: from mail-oo2-f9.google.com (mail-oo2-f9.google.com [74.125.231.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E103D20E023
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792023612; cv=pass; b=QHg7h7QUCwEm/6gxGWNzARgOPzPHtXFjqf9H8j17ozMjeFzx/JTQ2eg4nMCgJCT4lx5EE0rVXa+1QhCCP6327sVxts8JudgxRGZd1wjjyqpeRx/OKrfOms3QmQlKSzMqYX/ostFB86F9NtOojMqJJwubXp4uO+AFPPjl48FDGHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792023612; c=relaxed/simple;
	bh=ZfGhT2Jr+2O8ROlVSInvFbbLTE0fR8G5uMhgAbwj5M8=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=s8TBPziWhYgeO64XPsHrJ2WATXWRApc7S1w34Vrx+xyz6KCmWGxDBtQrfak/5t188T+iECpQXp+nsvGsnQL4YIkHFJ3Guwa76pr2sGlrlmNUmvR7OqjTfnX+Xv2iQgq3QxU3lheE4wkaAiIc4YzRexsTS6pH0Ag8CQvWAS67gAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com; spf=pass smtp.mailfrom=trukhin.com; dkim=fail (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b=De5LcNH5 reason="key not found in DNS"; arc=pass smtp.client-ip=74.125.231.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trukhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b="De5LcNH5"
Received: by mail-oo2-f9.google.com with SMTP id 46e09a7af769-821a4a69647so2048015a34.0
        for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 17:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792023610; cv=none;
        d=google.com; s=arc-20260327;
        b=qQv84KPr4J3Hm3VIH/fPeBtFyNyZKSA92eoWqiYKANQ7XYi3el82FnKf5kNqnQGJZb
         WIKvrIgbbS3nkCCLhICb4TqVAbnqePINZgWh3E8Db4P4jwMrqzySBbLNK1nISzLCkPyd
         Fl1Xvdkx1HnTpXobzirsN726CM1chVXs/y0yV32L1vwhIrPZupUNJQLY7IxtbaAldgeU
         pfYLkx8h3nbeox+N8n+VrUaPrR4LbUlVMvgN/3GODWo4Hq+NPJJn3FwAkeWxx0akUzaz
         Kl3cFc74p5uAUvSSTHwlwpMYB7NTU3i15Ev0HxukbzsEnSOPYJAvQRfNV4D4Y+Hg59Js
         8G7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=JaQsBngKHxTZEacWBZCQKm7YBXuRdNkKZ2aKH9fBHn8=;
        fh=j38K+UZvnLoeCRXSb9L7jvI480abVYAeM33CfdH/83U=;
        b=JaWlNkm7vyvB2bngA3gSuEWPZysjwxEGQnhYmukKdDLq+kOWvdWn9sCkNzFDA6hlwj
         GmD5BUJO5PGS4opV76uB83qWJLlAAWY3AAC+7xIn4SFEmE4RWYo0Z6JrhtyTIJLsrLT9
         pz+YxdRJ+RMkVnYL34f1BbUJ4k5Fvp0cPGd36m/AzTLoHKk8S5J2ClC0h9eA3rumUWUH
         lrnnPMt26uSnm4VwqZI/KbzFTPz8tZJLAWADqQ+ioGprwKZs/ZKjq2tcoj+LeRm81ro+
         KHWftvvKjv3gVxT/lyiTIyabtXVtkgb9RPm7pjDZ82wXd6/FM8dT+e9WSWbHOyAbz6zY
         0SBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trukhin.com; s=google; t=1792023610; x=1792628410; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JaQsBngKHxTZEacWBZCQKm7YBXuRdNkKZ2aKH9fBHn8=;
        b=De5LcNH5Is7o/oieBzq98U4udRGLXWzrXGGP+2jtkmE/X30MjIlMYpfl9XZR5BCv1q
         e/VXrI6PCRxfF//sQMQXn2SgwXsJe4wfc1ozaQcTfdKcP88nGjWgn0kABBYkherwO5kn
         M9TOylsiCtXc21qS2OQTIIDNbLsvRnTzLf2leRjqKPZa86sVH7q+VdUOvIBtud2eJZ1s
         zDijxEivSMBzeDhPUqzhZBB8lcIYKgwBuWEklPaZHhLbpDd5uErgXRzvQztq9lAAFYjy
         YRacS4Udc0IZ/y+vj8X68+YpGW5/K62QEziNa5FmZEUcpDwCVe/ZGnRfaHNs8yw6UjcL
         JeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792023610; x=1792628410;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JaQsBngKHxTZEacWBZCQKm7YBXuRdNkKZ2aKH9fBHn8=;
        b=NtgjAlUcpFBdErNzPPw8sGP9OCFX3EPlQ9uE4lCr1JXAxoGQSLgFBr2CndwcFrtLRa
         dnq1ny0g55wgEsjB3rw0qARMpaxLvOLTut6edpIVvpFwC2uc5SjW15Jb4uka2KSiJAab
         V7Fa86RbRRG3noaDtEagXSPPCrxRZfRt2Fo4ofBJLHlpm2UZ82Ak284AdBP8/DJHaq2d
         rVuji8HeKoUuD4Ps8ep+T6zxSVWHE2vjpv9mPBs9e62hPJKerWHPCsKUM2hSnOjGlAqD
         QPd96df0Q8+WNyLf0Y2l61o3F/KOH+a6my8PWWdPmZYmFm5ZSVrVygLdEdWRIQnoNxhh
         nV5w==
X-Forwarded-Encrypted: i=1; AKwUvByjvDFUIaMpJbXTX0wNJ5esT6Zldz5AdCpabTY/kH62TnhANKmUElP0FaG1oZ081POgZrFv1HiaqM8+M0XtkjA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRyXG6qjeS9Ntxe0DRDfBDOk6Uoki3o6VDlrp7fiNHifBeJ639
	37SWLDxthjKKiausamAdgLWy0b2Gu9Z/B6gqlE4OwpyN3ahl+KDFi/HeRkh5mmrYcZoJxKNstCF
	/1DiX+N/5xQeglYigHxDNE9/ACSKXv/ZW/B5LZQt0fg==
X-Gm-Gg: AYBFou2nSncjLLKhUtRia/DoGjrjwCsn1LieVX+JDGJNgYBu7tXuwLqBtjjKOTWsRZJ
	8hxuWN8rfjPvvOVCfG7PUzYpOwsW4763ko6wavfxoUz/5Vd22wQ72UwoI1R4Fc1vuTlgHNa1Vo9
	jbFdzB0Xl6BSwdQOqxcPor71dRzAHIqGHDEZd2CaB60ZhsaHCoLRBnMvoiTyDHhCX0okfKwaHbZ
	n0xr1cgbs60Wjxsqo1l7s11jtRIv1fhgcC+tWJ8eoPHAZ4AfVsNwNlf5FNGFxnSqy1pJO6ntO7D
	Wj48Z1/HBS5lzV1zHRraAQ+howEswcIhYuV4KmZdH0x9+HChshARMuXjO7tmEGoAxIcOv8+Vcpo
	5qQyyuojelV2I9VyVROp1wAQ=
X-Received: by 2002:a05:6808:f88:b0:4d7:17d5:6c9b with SMTP id
 5614622812f47-50c40a3e034mr15534514b6e.9.1792023609360; Wed, 14 Oct 2026
 17:20:09 -0700 (PDT)
Received: from 121308794542 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 20:20:06 -0400
Received: from 121308794542 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 20:20:06 -0400
From: Iurii Trukhin <yuri@trukhin.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 20:20:06 -0400
X-Gm-Features: AclHuK-R2VI3EMAmxypOk8j1RNgr0sS8TKkXhCdHLAm5TtP6ChLUvq5ggexLBu4
Message-ID: <CAOx7e9K707oLMN94TC=FBBZYKnwACsN-8mDVjsL+N+BBCmWTOA@mail.gmail.com>
Subject: [PATCH] checkpatch: add vmalloc() and vzalloc() to alloc with
 multiplies check
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Iurii Trukhin <yuri@trukhin.com>
Content-Type: text/plain; charset="UTF-8"

vmalloc() and vzalloc() have 2-factor multiplication argument forms
vmalloc_array() and vcalloc() in <linux/vmalloc.h> that protect against
integer overflow during size calculation.

Commit 070580b0b174 ("checkpatch: Suggest kmalloc_obj family for sizeof
allocations") updated ALLOC_WITH_MULTIPLY for the (kv|k)[mz]alloc()
family to suggest kmalloc_objs(type, count, gfp), while vmalloc_array()
and vcalloc() retain the (count, size) signature.

Extend ALLOC_WITH_MULTIPLY to warn when vmalloc() or vzalloc() is called
with a 2-factor sizeof() multiplication and suggest vmalloc_array() or
vcalloc() respectively, including --fix support. Also include the 'v'
prefix in ALLOC_ARRAY_ARGS so swapped sizeof() first arguments to
vmalloc_array() and vcalloc() are flagged.

Link: https://github.com/KSPP/linux/issues/342
Signed-off-by: Iurii Trukhin <yuri@trukhin.com>
---
 scripts/checkpatch.pl | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 8a7787d228a6..651a46f1fc40 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7355,10 +7355,11 @@ sub process {
 		}


-# check for (kv|k)[mz]alloc with multiplies that could be
kmalloc_objs/kvmalloc_objs/kzalloc_objs/kvzalloc_objs
+# check for (kv|k|v)[mz]alloc with multiplies that could be
+# kmalloc_objs/kvmalloc_objs/kzalloc_objs/kvzalloc_objs/vmalloc_array/vcalloc
 		if ($perl_version_ok &&
 		    defined $stat &&
-		    $stat =~
/^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/)
{
+		    $stat =~
/^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k|v)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*(?:,|\))/)
{
 			my $oldfunc = $3;
 			my $a1 = $4;
 			my $a2 = $10;
@@ -7366,6 +7367,8 @@ sub process {
 			$newfunc = "kvmalloc_objs" if ($oldfunc eq "kvmalloc");
 			$newfunc = "kvzalloc_objs" if ($oldfunc eq "kvzalloc");
 			$newfunc = "kzalloc_objs" if ($oldfunc eq "kzalloc");
+			$newfunc = "vmalloc_array" if ($oldfunc eq "vmalloc");
+			$newfunc = "vcalloc" if ($oldfunc eq "vzalloc");
 			my $r1 = $a1;
 			my $r2 = $a2;
 			if ($a1 =~ /^sizeof\s*\S/) {
@@ -7381,9 +7384,13 @@ sub process {
 					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
 				    $cnt == 1 &&
 				    $fix) {
-					my $sized = trim($r2);
-					$sized =~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/;
-					$fixed[$fixlinenr] =~
s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1
. ' = ' . "$newfunc(" . $sized . ', ' . trim($r1)/e;
+					if ($oldfunc =~ /^v/) {
+						$fixed[$fixlinenr] =~
s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*(v[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1
. ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
+					} else {
+						my $sized = trim($r2);
+						$sized =~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/;
+						$fixed[$fixlinenr] =~
s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1
. ' = ' . "$newfunc(" . $sized . ', ' . trim($r1)/e;
+					}
 				}
 			}
 		}
@@ -7397,7 +7404,7 @@ sub process {
 		}

 # check for alloc argument mismatch
-		if ($line =~
/\b((?:devm_)?((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/)
{
+		if ($line =~
/\b((?:devm_)?((?:k|kv|v)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/)
{
 			WARN("ALLOC_ARRAY_ARGS",
 			     "$1 uses number as first arg, sizeof is generally wrong\n" .
$herecurr);
 		}
-- 
2.56.0

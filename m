Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3318C4AC162
	for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402219; cv=pass; b=EEx8aSuc5rC1jpxQ5eERBdB7ud0ODsn7p+NooZalQDnuMn3qFamc+giB5Hy79dFDYsdKmfzcpwVanljSHEDa1odel56wbGf1MYZDdF5DAcNb3EXSD4gP28Uwc1FIKCor4eLXL/E/V3CclOol0x+xu02ISTaeHloLZegqR0rSY6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402219; c=relaxed/simple;
	bh=jAUHDM6KlIGBMEUV2aGs13eN2XOdVupRHbMZRHltREY=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KM/04XR20ofuTFodrZCD19dBR9IkePlprvMEegR3DSYO8umHqEmXg4NUogGvFRqgR/qUVn/GS6aXHNPMHMohIoGmr7ruPcIc0o+tvz07gjG9p0QNFlQwWMK0gYrSHIkFSiuempmlpxsCfYzLdyHpxG/PJ+MMgSsbxhtXTaqIDVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com; spf=pass smtp.mailfrom=trukhin.com; dkim=fail (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b=I4UOy0JJ reason="key not found in DNS"; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trukhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b="I4UOy0JJ"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-53656465d1dso1000442b6e.2
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 02:30:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792402216; cv=none;
        d=google.com; s=arc-20260327;
        b=aKCzn5Oj3MZHbn5JNV5heA9i8oWBKVfdo03ms433Wm0epxdD7l0y33ME0y6LLcGCWI
         l6Ae67RMCRlwXZgKdFeIlmp3gpRmddEVHZz6JrvLwDjLvMlGzrVRR7A/FsYrjL6hxX9j
         ALF7/GJAFOsblVzr1km99BFO2V6avLZs+7b5cfi+Y3P8zEOt1xl44hqn26Xz+0Jhr7HW
         Xd+lxvFAylqn8/nz9gtbg+D/hkH99O4Ml8FksgYrUXzOYUL9dWB33lWEE9waU2ca75Ab
         hQQTuEmvKzq1D0tsHvrKnNtxNKfDam50Vq90dGBTIlRJgVw5sVEIlbV0N1uhFtoIxFT4
         4yPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=Eh/J8sa1ZXlP+J7kkqHC8pH7/PspxhgOMogC7EkDAh4=;
        fh=WXQ3cd4gLt4q+ekDPjxZ5hN0lpRVEgIGFH5GP8eC5OY=;
        b=XFsmjiJQss3nP8eBjswyBJeIHfa04ZpPxVTVf317z/1Xl0aAnRkjEtuEmo/zCv+n3O
         hjnWblJSmYmPiSGQ6Lj4NBCqvYPgszlb8qz1U83daYCPUDm0QiZMezcyaRiMwmcqMtwq
         PusB9Kae8dc4xc5OHs02C5WyIEy99dn+MEdsMzX7gzxduM6LlWlryboLQmFY4EI7MGUY
         6idB3bcMbXgDHLvxxYoJ9cRcU1jKoBLcokHSlBnIHEjRhfKTwvK9elzNzgdBsR+LpHFW
         EX2dDBVk8iUmaX+VwOXYJYui3vCQAt6gbZmFFfX+Bwp0cRNDUPf6KBN2+R81vCmwboPT
         N7NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trukhin.com; s=google; t=1792402216; x=1793007016; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eh/J8sa1ZXlP+J7kkqHC8pH7/PspxhgOMogC7EkDAh4=;
        b=I4UOy0JJIhSmIwWc1xYOX/85SYl1KhLFBg/Rk1Oia8jqkO/OIeNmqfNWcIeU9aiPje
         V0vjyyt/F+ZISsWd4FA797Y2mT3xjkrw394bAtNQ9RBKw8tU40YiJmeuFfUAH9kWUTOb
         TN0vbJjbj59LWuPRUosIe3RpW+PUBF2/2e3Yzac1lxrrzmNcBQVNU3ykQDpNdLhWftXD
         LVkr79/9i8FZ9TBHB3QtZCgPlHHUvWIqJHc2QNEOA0YKS5P1TFbAJGMxIcx43RrTj4Qb
         6QlT463mxPf3xlBKEyWd82XnGtwf6CXoqMDaQiVeazXKvK4TGCQKSI/7ytnBaDcHjMK9
         5cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792402216; x=1793007016;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eh/J8sa1ZXlP+J7kkqHC8pH7/PspxhgOMogC7EkDAh4=;
        b=VyUPfr26EqzlrovNZZvOhA9yNzlWFUrjRtj+V7CWrWgQZbdYSp8t1BBrZ4tixGabGP
         dPl7z8BsRYVgibixLSL7cVnOsHDC9jXU0jhVGxyqBmmAykboZkI4tA33oJDsYG8yMhFM
         GVMTxkCGKa+qjNHlgMk+tVFJFIb32nMQoQbyFWnRLVkc2W17Y4mW8HuSLEF7mw5zKDMH
         OKXNZAr0MVsLzx0kaLBXEsfvMadRQYUMA1IUQ0qC8gMY9su0b4pQvuA9b5Fbazsisia0
         p+S/iuO4stC67U6sS2rMpy4+3wuqPwc0afJ+BR4Ca8WEOHjTGTTBOX3BH5fchP3gVdeL
         EIGg==
X-Forwarded-Encrypted: i=1; AKwUvBza57U96u0YNrHVH8g8siuxHLL1UPSyij6BdVYPM4EXAAqdzpPDaQLaRwG5ePaLymo8/YoXgCKx46D8XI4QISE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRf563pj971Cl4psQGrQSC5PSesuAafd7GEfKueiGWMb9zyMbf
	kdmXTJlgB7h3lzyv/vsPox9C7Du+XvEK5jPLNcNyzWYt06D7YQIdfHMSYVSPkB5AuofV/X2YaDP
	p/cAuz3IOt3AWe4LXgJUpWwlDIh879yW8OHeJbf1O0A==
X-Gm-Gg: AYBFou2cZ098L+ngmsdlPPeuj8EZ06aJLSkVmPQavVnIDv/mHtD2j3tKWF5uNNNNvUZ
	8oKMEiIfP4Ja5YoeVgxJkGOZy9smPk/ZCSYjMuL6XUKpPkWlsXddfzJgNO7l1qKUiz3NKFDnacz
	whvVj31iuDchyvSxjRQ/7NR+i8B8Z7NRl0p+mOKOnX2puV6A+fDYgVNj44GLM6QjfaSA+4Ffgnr
	Y7nn1Fc9SiQVSZW+d6Xa72TLKtoi+aETlBF1OILLLwIv6ftXKPiFGNl+2HwOfrT4T5NnVAXhk0V
	l9Ouxh+qYvoIAexhuIThsZaLTgq349VXdiNVVrINAIdezOIY/qZw9u5ETbGV+xFgNXde48Tzlte
	W5priu+4S2E6nKnfA1jBtJEBn6SM1KjASDRfue4vB7ZQN1om5pENaJ02l0qeuLkpz6io=
X-Received: by 2002:a05:6808:6b8a:b0:4d6:90f4:48ab with SMTP id
 5614622812f47-53ccfba424emr5467777b6e.45.1792402215962; Mon, 19 Oct 2026
 02:30:15 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 19 Oct 2026 02:30:14 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 19 Oct 2026 02:30:14 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Iurii Trukhin <yuri@trukhin.com>
In-Reply-To: <CAOx7e9K707oLMN94TC=FBBZYKnwACsN-8mDVjsL+N+BBCmWTOA@mail.gmail.com>
References: <CAOx7e9K707oLMN94TC=FBBZYKnwACsN-8mDVjsL+N+BBCmWTOA@mail.gmail.com>
Date: Mon, 19 Oct 2026 02:30:14 -0700
X-Gm-Features: AclHuK_3S2Q-iqOejvzcO_gf6XMyi3PI7nTaK6nu8aXVLn1sYlRVjmfZBuhTZpo
Message-ID: <CAOx7e9KafYk03k-5vPLm=ud4NKxm5kw79uYaci2qTEWFNknPtQ@mail.gmail.com>
Subject: [PATCH v2] checkpatch: add vmalloc() and vzalloc() to alloc with
 multiplies check
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

vmalloc() and vzalloc() take a byte count, but ALLOC_WITH_MULTIPLY does
not suggest their overflow-checking array helpers for allocations such
as vmalloc(n * sizeof(*p)).

Extend the check to suggest vmalloc_array() and vcalloc(). Unlike the
k/kv object helpers, these functions take a count and a size, so keep
the sizeof expression when generating a fix. Use the original source
for both factors to preserve strings and comments masked in the parsed
statement, and leave the fix alone if another check has changed the line.

Also include the v prefix in ALLOC_ARRAY_ARGS to flag sizeof as the first
argument of vmalloc_array() and vcalloc().

Link: https://github.com/KSPP/linux/issues/342
Assisted-by: LLM
Signed-off-by: Iurii Trukhin <yuri@trukhin.com>
---
Changes in v2:
- Preserve strings and comments in both factors by using their original
  source positions, instead of the sanitized statement.
- Preserve allocation casts and skip the fix if another check changed
  the line before this rule ran.
- Acknowledge coding assistance.

v1: https://lore.kernel.org/all/CAOx7e9K707oLMN94TC=FBBZYKnwACsN-8mDVjsL+N+BBCmWTOA@mail.gmail.com/

Testing:
- perl -c and checkpatch --strict.
- Allocator regression cases, including factor order, nested expressions,
  strings, escapes, comments, extra factors and multiline statements.
- Compiled and ran 12 generated C expressions to check that the rewritten
  allocations preserve the original size calculation.
- Compared the existing k/kv diagnostics and fixes with the unmodified
  script; checked application to mainline, linux-next and mm-nonmm-unstable.

LLM assistance was used to extend the rule, review the change and develop
and run the regression tests.

 scripts/checkpatch.pl | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 8a7787d228a6..cf2dd0b7c372 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7355,17 +7355,22 @@ sub process {
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
+			my ($alloc_start, $a1_start, $a1_end, $a2_start, $a2_end) =
+			   ($-[3], $-[4], $+[4], $-[10], $+[10]);
 			my $newfunc = "kmalloc_objs";
 			$newfunc = "kvmalloc_objs" if ($oldfunc eq "kvmalloc");
 			$newfunc = "kvzalloc_objs" if ($oldfunc eq "kvzalloc");
 			$newfunc = "kzalloc_objs" if ($oldfunc eq "kzalloc");
+			$newfunc = "vmalloc_array" if ($oldfunc eq "vmalloc");
+			$newfunc = "vcalloc" if ($oldfunc eq "vzalloc");
 			my $r1 = $a1;
 			my $r2 = $a2;
 			if ($a1 =~ /^sizeof\s*\S/) {
@@ -7381,9 +7386,20 @@ sub process {
 					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
 				    $cnt == 1 &&
 				    $fix) {
-					my $sized = trim($r2);
-					$sized =~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/;
-					$fixed[$fixlinenr] =~
s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1
. ' = ' . "$newfunc(" . $sized . ', ' . trim($r1)/e;
+					if ($oldfunc =~ /^v/) {
+						# Preserve strings and comments masked in $stat.
+						if ($fixed[$fixlinenr] eq $rawline) {
+							my $raw1 = substr($rawline, $a1_start, $a1_end - $a1_start);
+							my $raw2 = substr($rawline, $a2_start, $a2_end - $a2_start);
+							($raw1, $raw2) = ($raw2, $raw1) if ($a1 =~ /^sizeof\s*\S/);
+							substr($fixed[$fixlinenr], $alloc_start, $a2_end - $alloc_start,
+							       "$newfunc(" . trim($raw1) . ', ' . trim($raw2));
+						}
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
@@ -7397,7 +7413,7 @@ sub process {
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

base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef
-- 
2.56.0



On Wed, 14 Oct 2026 20:20:06 -0400, Iurii Trukhin <yuri@trukhin.com> wrote:
> vmalloc() and vzalloc() have 2-factor multiplication argument forms
> vmalloc_array() and vcalloc() in <linux/vmalloc.h> that protect against
> integer overflow during size calculation.
>
> Commit 070580b0b174 ("checkpatch: Suggest kmalloc_obj family for sizeof
> allocations") updated ALLOC_WITH_MULTIPLY for the (kv|k)[mz]alloc()
> family to suggest kmalloc_objs(type, count, gfp), while vmalloc_array()
> and vcalloc() retain the (count, size) signature.
>
> Extend ALLOC_WITH_MULTIPLY to warn when vmalloc() or vzalloc() is called
> with a 2-factor sizeof() multiplication and suggest vmalloc_array() or
> vcalloc() respectively, including --fix support. Also include the 'v'
> prefix in ALLOC_ARRAY_ARGS so swapped sizeof() first arguments to
> vmalloc_array() and vcalloc() are flagged.
>
> Link: https://github.com/KSPP/linux/issues/342
> Signed-off-by: Iurii Trukhin <yuri@trukhin.com>
> ---
>  scripts/checkpatch.pl | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 8a7787d228a6..651a46f1fc40 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7355,10 +7355,11 @@ sub process {
>  		}
>
>
> -# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_objs/kvmalloc_objs/kzalloc_objs/kvzalloc_objs
> +# check for (kv|k|v)[mz]alloc with multiplies that could be
> +# kmalloc_objs/kvmalloc_objs/kzalloc_objs/kvzalloc_objs/vmalloc_array/vcalloc
>  		if ($perl_version_ok &&
>  		    defined $stat &&
> -		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
> +		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k|v)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*(?:,|\))/) {
>  			my $oldfunc = $3;
>  			my $a1 = $4;
>  			my $a2 = $10;
> @@ -7366,6 +7367,8 @@ sub process {
>  			$newfunc = "kvmalloc_objs" if ($oldfunc eq "kvmalloc");
>  			$newfunc = "kvzalloc_objs" if ($oldfunc eq "kvzalloc");
>  			$newfunc = "kzalloc_objs" if ($oldfunc eq "kzalloc");
> +			$newfunc = "vmalloc_array" if ($oldfunc eq "vmalloc");
> +			$newfunc = "vcalloc" if ($oldfunc eq "vzalloc");
>  			my $r1 = $a1;
>  			my $r2 = $a2;
>  			if ($a1 =~ /^sizeof\s*\S/) {
> @@ -7381,9 +7384,13 @@ sub process {
>  					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
>  				    $cnt == 1 &&
>  				    $fix) {
> -					my $sized = trim($r2);
> -					$sized =~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/;
> -					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . $sized . ', ' . trim($r1)/e;
> +					if ($oldfunc =~ /^v/) {
> +						$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*(v[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
> +					} else {
> +						my $sized = trim($r2);
> +						$sized =~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/;
> +						$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . $sized . ', ' . trim($r1)/e;
> +					}
>  				}
>  			}
>  		}
> @@ -7397,7 +7404,7 @@ sub process {
>  		}
>
>  # check for alloc argument mismatch
> -		if ($line =~ /\b((?:devm_)?((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/) {
> +		if ($line =~ /\b((?:devm_)?((?:k|kv|v)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/) {
>  			WARN("ALLOC_ARRAY_ARGS",
>  			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
>  		}
> --
> 2.56.0

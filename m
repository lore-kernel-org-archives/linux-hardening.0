Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC04B2B9AD
	for <linux-hardening@vger.kernel.org>; Thu, 19 Sep 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726727220; cv=none; b=MRzz0kZE3vj4nPjJLGcV7ZA33SV+jnCTaDYULs9zlqxIa4FOG95jKkV5R4pNZIpOVv3nUWWYInqEkWZIK81L5wHzBmt+3Fziw0+7ASFvV1a3l1qx8AbuyBgtYv8MAwwo8ab+pC1e1bUhj5/3vAUjpVMZl8Uj3CSZ/BDZP949fpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726727220; c=relaxed/simple;
	bh=lUpe7mEKt4IKqjVaiYnO3rC7ndMa6lJfLy9odGtnUtE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nB/VaVf+awZb2drg/sRPUklJdHWkFuDYOjxdE7o4IgcG7/NYgW8iz6WQGYxggUAo76r2K0TfhvL7qZJH4SnfDAkKdlFpWTerXMusxO03lea7Bh4ndy7icHmglcAmyVXD9bf3wnIE7uU/LN732JEUxlquH7Av7yItGLpnJF2UUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Uaor4ODM; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Uaor4ODM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OZuqA97ej9SOaI/vTpBcIYBQJ5KlkVSZ9zI8F+YYuaU=;
  b=Uaor4ODMo0xIGJjysiw9ZeyqHd/Ux+wD8s1CRB0biQYN+mIK8HIJ4vI+
   JILyBGZmvCsX4UfM7PstDlIeFb4j4qLBYQX9wFR7Yt+teQOyRh1fN6TzO
   Nq2nQ7mHTbvKIjQtJAk12lLfUzg26A/cDC17eJlGzxwvdJVNq9vRuCXxC
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.10,241,1719871200"; 
   d="scan'208";a="96784530"
Received: from 81-223-29-78.static.upcbusiness.at (HELO hadrien) ([81.223.29.78])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 08:25:46 +0200
Date: Thu, 19 Sep 2024 08:25:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Hongbo Li <lihongbo22@huawei.com>
cc: kees@kernel.org, andy@kernel.org, nicolas.palix@imag.fr, 
    linux-hardening@vger.kernel.org, cocci@inria.fr
Subject: Re: [PATCH -next v3 01/10] coccinelle: Add rules to find str_true_false()
 replacements
In-Reply-To: <20240911010927.741343-2-lihongbo22@huawei.com>
Message-ID: <2aefba9e-f04e-4ee6-60cb-a139c0641ff1@inria.fr>
References: <20240911010927.741343-1-lihongbo22@huawei.com> <20240911010927.741343-2-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 11 Sep 2024, Hongbo Li wrote:

> After str_true_false() has been introduced in the tree,
> we can add rules for finding places where str_true_false()
> can be used. A simple test can find over 10 locations.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  scripts/coccinelle/api/string_choices.cocci | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
> index 5e729f187f22..6942ad7c4224 100644
> --- a/scripts/coccinelle/api/string_choices.cocci
> +++ b/scripts/coccinelle/api/string_choices.cocci
> @@ -85,3 +85,22 @@ e << str_down_up_r.E;
>  @@
>
>  coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e)
> +
> +@str_true_false depends on patch@
> +expression E;
> +@@
> +-      ((E) ? "true" : "false")
> ++      str_true_false(E)
> +
> +@str_true_false_r depends on !patch exists@
> +expression E;
> +position P;
> +@@
> +*      ((E@P) ? "true" : "false")

Hello,

The semantic patch is quite slow.  Actually it tests a large number of
cases, eg where the parentheses are present and where they are not.

A small optimization is possible in the non-patch case.  The outer
parentheses are not needed, because you will already get the same
information whether they are there or not.

In contrast, for the patch case, the outer parentheses are needed, because
if they are there we want to remove them, since they are not needed for
the function call.

Could you update the depends on !patch cases to remove the outer
parentheses?

Also, just one patch would be fine.  There are many changes, but they are
all sort of the same, so it would be easier just to see them all at once.

thanks,
julia


> +
> +@script:python depends on report@
> +p << str_true_false_r.P;
> +e << str_true_false_r.E;
> +@@
> +
> +coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)" % e)
> --
> 2.34.1
>
>

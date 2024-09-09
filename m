Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD65F2374C
	for <linux-hardening@vger.kernel.org>; Mon,  9 Sep 2024 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897705; cv=none; b=PHUeJNGnXWaTyVXmLaoixVROISDeV7u1UGEFHvOj7I2N/acNz0ZhZ5JA1QHxm9EHu5I3/GQbuAlSDYIKNvIo20Je6joW/F9a25pM/ePX+6q1KRimkocMUlk0eGZMsMUHnbmIld/JHbokVWfu3rnwjN5DCB5Je0t6qYmAuE8w9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897705; c=relaxed/simple;
	bh=ZIR89CWPAUzyUiHNwVx8faRVy0XnrHW3i+ZdYzmuWEk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DIrXWvfK0MNiVDJc6toFSUhg/cJSthXqdSYlww1PfaNZ52iDRiu6RDi0QKKtLBZmSt2ZpR0bUAbzh6NpnaArGTc/UGZkzuo/MiEXzXxmTiIIcohFMOlUoyNFCOfFBat2AUu8nPOFDlY78uasqzg+j+/G941gkgKDbnWbPX+QMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Wg8i0E6j; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Wg8i0E6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lonUSnqdTD88ZPU2zJHgdmx3mLDJED+oxqZbrLmNd+Y=;
  b=Wg8i0E6jOTB6ngFAFJG8yuBBCUBrra+5M0ZoQcn72ZiNlfUg/LcMEbkL
   u8mGtjoF1/QdpKlnIyAMqNWT4fdpwrlmH56sZOWbxpVqgR7ktl5pXml+0
   pBc4m0+ur5L/rEW0kbjlg1iS2pP7Jh1nlLr/dpSiiUcs5j1MUsrkcyfQz
   U=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.10,214,1719871200"; 
   d="scan'208";a="95838497"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 18:00:31 +0200
Date: Mon, 9 Sep 2024 18:00:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Hongbo Li <lihongbo22@huawei.com>
cc: kees@kernel.org, andy@kernel.org, nicolas.palix@imag.fr, 
    linux-hardening@vger.kernel.org, cocci@inria.fr
Subject: Re: [PATCH -next v2 1/9] coccinelle: Add rules to find str_true_false()
 replacements
In-Reply-To: <20240904091451.3328272-2-lihongbo22@huawei.com>
Message-ID: <71436945-5386-ff6e-8e8c-b513d4509241@inria.fr>
References: <20240904091451.3328272-1-lihongbo22@huawei.com> <20240904091451.3328272-2-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 4 Sep 2024, Hongbo Li wrote:

> After str_true_false() has been introduced in the tree,
> we can add rules for finding places where str_true_false()
> can be used. A simple test can find over 10 locations.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  scripts/coccinelle/api/string_choices.cocci | 23 +++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
> index 5e729f187f22..50329c4c8acd 100644
> --- a/scripts/coccinelle/api/string_choices.cocci
> +++ b/scripts/coccinelle/api/string_choices.cocci
> @@ -85,3 +85,26 @@ e << str_down_up_r.E;
>  @@
>
>  coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e)
> +
> +@str_true_false depends on patch@
> +expression E;
> +@@
> +(

There is no need for the above.  That is only needed if there is a
disjunction, ie a set of possible changes.  Likewise no need for the ),
and the same in the next rule.

julia

> +-      ((E) ? "true" : "false")
> ++      str_true_false(E)
> +)
> +
> +@str_true_false_r depends on !patch exists@
> +expression E;
> +position P;
> +@@
> +(
> +*      ((E@P) ? "true" : "false")
> +)
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

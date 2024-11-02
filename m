Received: from e2i702.smtp2go.com (e2i702.smtp2go.com [103.2.142.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAAB14AD3F
	for <linux-hardening@vger.kernel.org>; Sat,  2 Nov 2024 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730581876; cv=none; b=TkIIQEo8PKzAS15cD6v09cQfLJVwHyxdjIoRTW7BwIcGPPvnARL+DR4l+FWnPuyzBjWZE/IIVHffzLEu0TZ8kZJE/BZEK3nh6SYWfCYSffc8tCwlr6LmQCg3jz84OSxSuUpBy6YUaT2NzmmGe9UXEI7jUQpU9cTw0wc0GvOxXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730581876; c=relaxed/simple;
	bh=S+ftkDW+EolfF4nLXvY08UrrEM8BzHoTWikhA2a4CTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYZUw33vUdq8AUbmCGd1nul7voP36NDIEj0W+1QnAW4kJW98DCN26voGdJu9bXxdGb7qTZPscnTkLOUh5+yrQasS4bhVcfz+Vk8XKg9EJpDD8n0s49rqGz1bCwT7gZs60tXd44dp2fLErkYJkz4B+xdclRFCl9uw+7yFPSXg76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Y4ploTQg reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=cpC9I8lV; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=1eVYB5TQ; arc=none smtp.client-ip=103.2.142.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Y4ploTQg";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="cpC9I8lV";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="1eVYB5TQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1730582766; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=n8zANEvJLM/G1kIHRS+1DDQaAHa0Nzk9++SIxtdojWc=; b=Y4ploTQgjiStNCwpxf+HNAThpv
	dxqLuV9yqgc0J6ehwi2siim7l7DEE0G3GrRDbrjysU8TDRIeU1bT1W9e/LDl//AQjnqcsxMZ5n8E0
	wMv4l/Ee4BOdY4FzRh3OsMJDG3CGsn2hejBRW5/lnOZ3rmOOHKo7sqzWJjnSiESOb1Gsd0PtXO5N4
	Mak0O9BwMcwnOIYuuKrd2ebMenr87hEiwVLI7hB9EQOvHWVurUl/paB7UbREr4gYulTNN8HORxCcQ
	p9HfoEVLmH1OVD7tQMvxPnoIKpJiyHakhL5g4ID6IVk4HTwBaomalzQPR9/4q0OF0lQnF7xpHkpcF
	jxKssa9A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1730581866; h=from : subject :
 to : message-id : date;
 bh=n8zANEvJLM/G1kIHRS+1DDQaAHa0Nzk9++SIxtdojWc=;
 b=cpC9I8lVfut5fM5xFBsBDbDS2A0FhjflVzbHYBd3FZK3D8A/23L1fhKfCzIECt4vC2kWs
 7v4lk/Sx2DaAo41i1IhKTaHcbnP2UGHxJ3hb4Kxyf5oXQCLjQ6Pw7n3j2t9dFN9+BnW2P2M
 SYh+2wT7iRi4lWhEFwj08Ux3CEhOe8MY+ft6Di7BoHLkmCmwkKTMLKwALE4Fhqe46t5He23
 S+L57BWXCcwt8zv7qBww94azVGnJ0SjG+OKX1utiYq5C73AgQgf1IJUVVx9WkmUocRpaZlC
 QKBpblJeP5m6HGA8BgaDXw3CeANYyESwHix4B38BWUFYMAN4EGSp6mdJkDyA==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1t7LNn-qt4K14-7W; Sat, 02 Nov 2024 21:10:07 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1t7LNm-FnQW0hQ0j5X-muyZ; Sat, 02 Nov 2024 21:10:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1730581802; bh=S+ftkDW+EolfF4nLXvY08UrrEM8BzHoTWikhA2a4CTQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1eVYB5TQeDufF9npVsPoeeXmKxebb162cfGGPzNiaqq0bYVD/yQSoWpmC6GQ/bBPr
 teEuctDed/3PkecGtmy382estuYal8Y5Cmn2Ms/e/kef1tJEpUOwaCNGwqMlOeJScS
 1HLq1i1yPDTQFFn+Ild6VmqnbOed4IB3EqONdhm0=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id D4B0C3D7A0; Sat,  2 Nov 2024 22:10:02 +0100 (CET)
Date: Sat, 2 Nov 2024 22:10:02 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Morten Linderud <morten@linderud.pw>,
 Haelwenn Monnier <contact@lanodan.eu>, Jann Horn <jannh@google.com>,
 Kees Cook <kees@kernel.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 05/11] kbuild: execute modules.order recipe in
 --dry-run mode
Message-ID: <ZyaVKm2VaezpHWo5@fjasle.eu>
References: <20240819160309.2218114-1-vegard.nossum@oracle.com>
 <20240819160309.2218114-6-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819160309.2218114-6-vegard.nossum@oracle.com>
X-UID: 189
X-Smtpcorp-Track: x2xzwjsplfIz.3uxzuZhNOIWR.01NlUg-nOLk
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286s-LvkLiyY-
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Mon, Aug 19, 2024 at 06:03:02PM +0200 Vegard Nossum wrote:
> modules.order is read by scripts/Makefile.modfinal to determine which
> modules to build, so we need this recipe to execute if we want to be able
> to output the recipes for building modules in dry-run mode.
> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  scripts/Makefile.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index efacca63c8976..34f86dced67f3 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -417,7 +417,7 @@ cmd_gen_order = { $(foreach m, $(real-prereqs), \
>  	> $@
>  
>  $(obj)/modules.order: $(obj-m) FORCE
> -	$(call if_changed,gen_order)
> +	+$(call if_changed,gen_order)

As it is a bit hacky to mark an always sequential command as 'recursive' [1] in
order to circumvent the '--dry-run', I'd like to see a comment in the code,
too.

[1]: https://www.gnu.org/software/make/manual/make.html#MAKE-Variable

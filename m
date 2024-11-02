Received: from e2i702.smtp2go.com (e2i702.smtp2go.com [103.2.142.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA58014AD3F
	for <linux-hardening@vger.kernel.org>; Sat,  2 Nov 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730581714; cv=none; b=KFgqDL+UpoiuIsNCbGwOyQROs+IZcaFBC6V7q+uQHZuOv77l2AJGFXwZjHeTKSY88lYSJuSB7umN9rKRedgz2reqYukvwE3wJa9Ua4WfAyH6xSEidi9Ib1jRJ1nTRFNaGWng0FFUe8VtQuwLJ91+cAL8ryZPTPrwMgFPfN8uVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730581714; c=relaxed/simple;
	bh=cO3hWwEfMbIltEmTMaVHnNGUQNtuqAECidpRtsXGisY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adKcygK9iKS6Yj2WbPlVGmtp2gG4B1Sp6VG9FAtSgSVOIx8lkQmAP6QLdvHO4VSBP3g9OZbJ8aH7VmAxLfgjsrwBW2vvXxcpkajlnw2vx1Bl60lU5v1rldhM6wxfoWV1VEiiNiWi98qckGnWEBiF7ueHWk2xHbYakW9oMMZO7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=NfITrkA2 reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=i4jAHcIi; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=mPxG+ZlL; arc=none smtp.client-ip=103.2.142.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="NfITrkA2";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="i4jAHcIi";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="mPxG+ZlL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1730582609; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=9ZmCQYZczcI9y3SOgBFfGiOqtjWhS7FouhMbjAYAatI=; b=NfITrkA2u74MrVungzjGbxSWN2
	u6OdsdrbYBb6mnJct2fIZ8uylbw9GM1xNQMOEHS/2GpkBk0hiPhxMe53hWEOV25nkOjJkr+MPg8ac
	Kew03SfcMNQo7ivDqpW044X3EhS3NuCOMa1aZ5dv0pO0zjTtCcycLHfFNhciq/BRxf8wZOfj0gYQp
	dyep931IPkNYCXgBoaLQ0ex5H7t2C/zAl5nJ1/cfafaXapV9p5zZwQ0JSc8JOUfdDSt+H3QgWRSId
	rqfaRpJL1A6f6TxlzTtLWelTJQ7r8PzIBZNWgCHk+4Pczvj+2wqaXq+Hcu5K9oKrGAOzPplvrDdV2
	DHhEGL4g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1730581709; h=from : subject :
 to : message-id : date;
 bh=9ZmCQYZczcI9y3SOgBFfGiOqtjWhS7FouhMbjAYAatI=;
 b=i4jAHcIiEcDoOX7QIkFghN3dRsrmPKYqMPNBcmaiA0viZofWj1EizFH6l8j/DYQLxxQmr
 fh3Bgoy9N+NKZWKMVqIc+dLSKTTRrsYc6VllER2Z2O/RVF5mh0W1kYawZxPP/05Z6bbANOD
 r3lW9ib84LeUob9TRZ6FU+IszB9JDKdoX8EhItij9ZO5ag9INDIn39qSoOC75Pmi7kJvsvd
 xGcg85klazMaCN10zmLEZiJUD3RueZo5hRhQjJDSuInlxOsGihBb/UWpJPiP+nQjaV4z0Y4
 8ncRIXKsbMDdDEdNE2fKnuoP3ar7kbOCo601v/C/IZfZELetRA49dKiH0OrQ==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1t7LLK-qt4Cyy-OZ; Sat, 02 Nov 2024 21:07:34 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1t7LLJ-AIkwcC8v3at-K04Z; Sat, 02 Nov 2024 21:07:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1730581648; bh=cO3hWwEfMbIltEmTMaVHnNGUQNtuqAECidpRtsXGisY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mPxG+ZlL8bqGVknfqLdujlUASDBOQOdY8DG/4aZk22nnZVSafWjWDXp6ynN6fA6CN
 a/A5iyF5W6+2iwPEOxmcX9hgZ1z1sXPxKFG7pjOqRSyOGv4fvnyRAg7RhXEmFkdLHZ
 DQmWUllQlzwjQNNE602/pGND8odpJiRjI22kx7sA=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id 4186E3D7A2; Sat,  2 Nov 2024 22:07:28 +0100 (CET)
Date: Sat, 2 Nov 2024 22:07:28 +0100
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
Subject: Re: [RFC PATCH 01/11] kbuild: ignore .config rule for make
 --always-make
Message-ID: <ZyaUkK57P4sL2uqm@fjasle.eu>
References: <20240819160309.2218114-1-vegard.nossum@oracle.com>
 <20240819160309.2218114-2-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819160309.2218114-2-vegard.nossum@oracle.com>
X-IMAPbase: 1553198760 0000000191 Old
X-UID: 185
X-Smtpcorp-Track: 3txsd6kJuUTl.3mJ-OjCBdAaL.xi7zNgX5kSS
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sJea5VhC7H
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Mon, Aug 19, 2024 at 06:02:58PM +0200 Vegard Nossum wrote:
> Before this patch, using 'make --always-make' would always result in the
> error message about the missing .config being displayed.
> 
> Detect the -B/--always-make flag and leave this rule out, which allows the
> rest of the build to proceed. See [1] for an explanation of this particular
> construction.

Nice catch, thanks.

> 
> [1]: https://www.gnu.org/software/make/manual/make.html#Testing-Flags
> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 44c02a6f60a14..f09c036daf2f5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -757,6 +757,10 @@ ifdef may-sync-config
>  # because some architectures define CROSS_COMPILE there.
>  include include/config/auto.conf.cmd
>  
> +ifeq (,$(findstring B,$(firstword -$(MAKEFLAGS))))

As we still also support make v3.80 to v4.0, please use $(short-opts)
defined around line 27.

> +# This is a dummy target, only meant as a help for the user invoking make.
> +# We don't want it to take effect when running 'make --always-make', since
> +# that renders the --always-make option effectively useless.
>  $(KCONFIG_CONFIG):
>  	@echo >&2 '***'
>  	@echo >&2 '*** Configuration file "$@" not found!'
> @@ -765,6 +769,7 @@ $(KCONFIG_CONFIG):
>  	@echo >&2 '*** "make menuconfig" or "make xconfig").'
>  	@echo >&2 '***'
>  	@/bin/false
> +endif
>  
>  # The actual configuration files used during the build are stored in
>  # include/generated/ and include/config/. Update them if .config is newer than
> -- 
> 2.34.1
> 

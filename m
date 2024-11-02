Received: from e2i702.smtp2go.com (e2i702.smtp2go.com [103.2.142.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D29714AD3F
	for <linux-hardening@vger.kernel.org>; Sat,  2 Nov 2024 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730581920; cv=none; b=S6YBjxmHLyVxlEc0helPnCQMM7IvshasDBHZa5/KF4ZAJ8HZRy3Q6ncJXlyAq/7w2EKYeh2Bip0cgQhZsK7ptpQy+GapBZi2ONlPxVDMDyIa50cynbN2iBSiSWLBchy1Gdz1b51MRPrS8X4x7Up1GHs6Mu8YGo54Lzuw5DdRW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730581920; c=relaxed/simple;
	bh=J07DlnM5y0IgSwLwOlgdAJoz6JVY1WPCt/oTAdL9wgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GO0EySsBIz5zVgrYtu29GQa7LKUnSdnffNO9NMa/2GhHe68AhZhv/6K74OfheNl0gRqYIMXdqYJwsk2BsEmADKLaWg/sHg+/ajvQTQ8dwZif4rYxjSsEMh2isvG05W1wU4IMxJUXUA1bPW4TzQUM7MVhX/7pbMQ12ugmWZ/jl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=s7EKvZ9z reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=IlU2+M6Z; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=4Z1kFXD6; arc=none smtp.client-ip=103.2.142.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="s7EKvZ9z";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="IlU2+M6Z";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="4Z1kFXD6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1730582810; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=zWaoI4SD49sleU/FrwHQLZPOqKSnr5NxHmOp5mAf5w4=; b=s7EKvZ9z7mVYSv0J1dvumENljA
	jNpKCuVoPZZChbqBu1tprkO/UjXDFYgtkqLxVCnB/cSXcJfLsH+KxiO4yXqcJXNJOHwv8rS08Uf1t
	3UNn5i03UGV8WOYWXrEqVNmB14wrPpHejrHQ4h+/B1uCWFerjNXS1gDcYjyVGXcZOeIycY+rbP5cl
	pZpl6CLni7WewMyXDszQa6Ar4M9sRi7PdfTQEuuH+oYjwl4c8lagvpc62xup3ezgs9M1AM8YOMgU9
	kOOeFC+vHTMzHSNZNo05Bv+H7c0I9jnUO8BEkgURXszmYDmsBA03SlhkMwl0at+fI9CJMZSO56V+Q
	M3WDHWTw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1730581910; h=from : subject :
 to : message-id : date;
 bh=zWaoI4SD49sleU/FrwHQLZPOqKSnr5NxHmOp5mAf5w4=;
 b=IlU2+M6ZF81w7jg8K2bW+vrMrFaMGjLdgYlv/Y8k81Q5yQP2X2Z2rxqgWL+xLJk1/eLAX
 sq1pUBW1SxYfCg6uRUDJfXsUnw0/FIw/AXUCD6vnybv/OV4ar8DzNZU9hJ7bfriD3iGcJxV
 op88tuXIhaEYlT9BXYc/99glJf71t2TOUSptFfXkIMpCOn6iLt1yZ0dLkM72FWn+jyCsRAF
 +/r6shga3mUVK9tlrCPDQlrZ7xaJpuu9rKQuQJAxZ6tpksACsQBuuU4yPeUqsQOsVmFKh9Z
 dvuzBIM/BeoXabrNY9iixJZvBNy2VgqVrXgJtRT/a0I8yJXkesOBADd2GbDw==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1t7LOi-qt4D5j-CC; Sat, 02 Nov 2024 21:11:04 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1t7LOh-FnQW0hQ0jh2-nLIy; Sat, 02 Nov 2024 21:11:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1730581863; bh=J07DlnM5y0IgSwLwOlgdAJoz6JVY1WPCt/oTAdL9wgQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=4Z1kFXD6fDlw6UFcmD+MHH4viIDZhu9cPwxcbh9DQDxToKGZjKRQuFJfpqhOkDvSk
 wnCEtU6T/6YFYB4emxOw7blQWKrZIdYQBByoDwMXen+tcqlUUC5wf1kvX8D2SHSMTb
 D/gmmBfC1dAKCUo+pU/c1Qkp4iHLNqRqlSmFFavA=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id 0A9753D7A0; Sat,  2 Nov 2024 22:11:03 +0100 (CET)
Date: Sat, 2 Nov 2024 22:11:02 +0100
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
Subject: Re: [RFC PATCH 06/11] kbuild: set $dry_run when running in --dry-run
 mode
Message-ID: <ZyaVZhPfiVszWhcp@fjasle.eu>
References: <20240819160309.2218114-1-vegard.nossum@oracle.com>
 <20240819160309.2218114-7-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819160309.2218114-7-vegard.nossum@oracle.com>
X-UID: 190
X-Smtpcorp-Track: vaHKhCcXIbZ8.MFGYCjnMM1S8.wVGYVg0VB_H
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sZAV7eZdDs
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Mon, Aug 19, 2024 at 06:03:03PM +0200 Vegard Nossum wrote:
> Add a convenience variable that allows us to use 'ifdef dry_run...endif'
> in Makefiles or '[ -v dry_run ]' in shell scripts to test whether make
> was invoked with '-n'.
> 
> See [1] for an explanation of this particular construction.
> 
> [1]: https://www.gnu.org/software/make/manual/make.html#Testing-Flags
> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 58f3843ccfac6..953951157ec92 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -22,6 +22,11 @@ $(if $(filter __%, $(MAKECMDGOALS)), \
>  PHONY := __all
>  __all:
>  
> +# Was make invoked with --dry-run/-n? Record this in a convenience variable.
> +ifeq (n,$(findstring n,$(firstword -$(MAKEFLAGS))))
> +export dry_run := 1
> +endif

As in patch 1: 
As we still also support make v3.80 to v4.0, please use $(short-opts)
defined around line 27.

> +
>  # We are using a recursive build, so we need to do a little thinking
>  # to get the ordering right.
>  #
> -- 
> 2.34.1
> 

I will have a look at the remaining patches within a few days.

Thanks and kind regards,
Nicolas


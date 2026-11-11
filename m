Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391567;
	b=EDFuX7hc2JfqtagjkgkIo4BLFRXG150WFMY5giSxi56/GFCnDbfGoGmHHEO3dppuH7pD
	 zfue3mlB9r9mSa6xIHwmtz7g7547tolCmSgrrIl5pHrvh4v5e6NObmt5twHtxjAhY5FHk
	 0wy/tz/f0du7baFnvD+/J6d3xg462iv3QWHL6u4pERypPYcr+UgdwuWoUNrRv9wRR99Nt
	 Df+Xg+dS2a2HMmZkyaoHKNUa3oLl31Zn1WJh8I1ZX+USjRETNw2y6q24iYjQSMnN1nKbb
	 /FjTUq9x4AhZ+N4E8nUKbkR1m9OdIdYCEgfdyRPlmBYZ9fXQiL/rC/YcNd11KiYtMkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391567;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Virus-Scanned;
	bh=+PZREDVu6udbS/MihShnEiQ1U4HP69UPMFupt24cgpg=;
	b=MHt8YtKHz9opTJgaSUdU+4lduQP6zr9agVSVOayBukRR/VviRkjygwGZUw9qqrxY01Qu
	 xaxdD2tCSLoA/lUhJVdGu6JSFXR0Gms96rhthKlTC3Akp119gCDh4U+zx/ueeyP4vB78K
	 2gMv4ea2jfA10/dUQ1r1cjekSIo0zz+8ka+1fJMC0qiyd+VvHn4LbFWAa89993ncb45xQ
	 eUQwiK6NiLsRKwe4EbX4d4u0IdUQ3rQTwXtMZJBliO1o4BHQAT62AlJnNBud4nuInjDu2
	 h55srBLMOjO5Hfygx6HV67SK/7hgIIBRVv0tPES55szn+CLE4kwYDYs3xvftHJs1/Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ew.tq-group.com;
	spf=pass smtp.mailfrom=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=eTjZemmm;
	arc=none smtp.remote-ip=188.40.3.216
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EE1606A321;
	Wed, 11 Nov 2026 10:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56EE1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=eTjZemmm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+PZREDVu6udbS/MihShnEiQ1U4HP69UPMFupt24cgpg=; b=eTjZemmmDK/nUMvH0MIwylgxRp
	zBJijZmwANAtGI6XeYJN0AaK1/WNNowTqDGffMcflPH0LtvMTl23DmEBiTmwg3zcuP+i8uo6VT5Ev
	h8Pltkah4Pvgl9RGNRfM2xO/i3iPo3ktotyka1EIQOVGsT2WPUTggvRz7HrcCT03LnHZnaQC2CtFI
	KfIDQcYamMU5azfY0oop856p6giY3X6ACi87PMYdvjN03G+NpXTiN4h+JiDlouhEOpA8GEe/H8p90
	/9N+qIVT/u8T3hEdEPLpbcSE/mfQ8j+j/CEAlBpFGpf+GADntCsBSlPaTUM/bPufoiIhkZ+DGN+9q
	bZ8HfCyA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1xR5DQ-0003dD-0D;
	Wed, 11 Nov 2026 11:06:04 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1xR5DP-000CYs-1A;
	Wed, 11 Nov 2026 11:06:03 +0100
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-sound@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Subject:
 Re: [PATCH] ASoC: soc-core: reset rtd->num_components after allocation
Date: Wed, 11 Nov 2026 11:06:02 +0100
Message-ID: <4024352.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
References: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Virus-Scanned: Clear (ClamAV 1.4.6/28180/Wed Nov 11 07:24:27 2026)

Hi,

thanks for the patch.

Am Montag, 9. November 2026, 11:25:20 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Emanuele Ghidoli:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>=20
>=20
> Commit 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the
> devm_kmalloc_obj() family") switched the snd_soc_pcm_runtime allocation
> in soc_new_pcm_runtime() to devm_kzalloc_flex(). components[] is
> annotated with __counted_by(num_components), so when the compiler
> provides __builtin_counted_by_ref() the allocation now also sets
> rtd->num_components to the number of allocated slots.
>=20
> snd_soc_rtd_add_component() fills components[] one entry at a time and
> expects num_components to start at zero. Starting from the allocated
> size, for_each_rtd_components() stops at the first, still NULL, entry,
> so the runtime has no components: they are not probed, no controls or
> user-visible PCM devices are created and the card registers empty,
> without any error message. In addition, each added component is stored
> past the end of components[]. On the tested board these stores still
> land in the slack of the kmalloc bucket that devres rounds the
> allocation up to, so KASAN does not report them.
>=20
> Reset num_components after the allocation.
>=20
> Seen on a Colibri iMX7D (simple-audio-card, fsl-sai, sgtl5000): the card
> is listed in /proc/asound/cards, but /proc/asound/pcm is empty and
>=20
>   amixer: Unable to find simple control 'Capture Mux',0
>   aplay: main:850: audio open error: No such file or directory
>=20
> Tested on that board with v7.4-rc2 built with GCC 15.2 (first seen with
> GCC 16.2): the failure is there without this change; with it, playback,
> capture and the codec controls work again.
>=20
> The root cause analysis, this change and the testing were done with the
> help of an AI coding assistant (Claude Code, Claude Opus 5.5).
>=20
> Fixes: 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the devm=
_kmalloc_obj() family")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

This fixes TQMa8MPxL/MBa8MPxL as well which is also affected by commit
4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the
devm_kmalloc_obj() family").
=46WIW:
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
> 4dd10fbbeb9c only reached mainline in v7.4-rc2 (not in broonie/sound yet),
> so this is based on v7.4-rc2.
>=20
> The other devm_k[mz]alloc_flex() sites added by 4dd10fbbeb9c were checked
> too: none of them fills a __counted_by() counter one entry at a time, so
> this one looks like the only user hit by the preset counter.
>=20
>  sound/soc/soc-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 68b54e509b65..06a1d5718997 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -387,6 +387,12 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runti=
me(
>  		device_unregister(dev);
>  		return NULL;
>  	}
> +	/*
> +	 * devm_kzalloc_flex() presets the __counted_by() counter to the
> +	 * allocated size when the compiler has __builtin_counted_by_ref(),
> +	 * but snd_soc_rtd_add_component() expects it to start from zero.
> +	 */
> +	rtd->num_components =3D 0;
> =20
>  	rtd->dev =3D dev;
>  	INIT_LIST_HEAD(&rtd->list);
>=20
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
>=20


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



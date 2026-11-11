Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376753;
	b=2mQkRcTKZ9rxEb0at2hUGdMQlcLPnK5n1AyPUaOKOWlJt7VsPjJyCY7SAPEC0v1FpwZ6
	 mu+uMM9hGK4tf+SGNUWWDMa4aB3vAM37SGSbrK0nFuY+mww7fb11PXpnvwUjIMocA4K6B
	 cFMna5NqSL3PPMWXDVZfFLbhvmXhiLshPIeTPQlgNuwCDuVlpYHeMYXixFIByTLFX6MV7
	 bp+H0Tv0ZA2LeAKG2icBx800Xq3zvy77ApJuQB6g4iSVBmoLvOJfmfpIYdFmSletZKYco
	 EnwW6CDB5p0dJjHAHsheTvS2r8Kjni2mgOkXGJ0K3ijyXGUfnZAhpodhfz85+eF4WpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376753;
	h=Received:DKIM-Signature:Date:From:To:CC:Subject:User-Agent:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ka4FTyAvq+CRe6XZnT1kLUAzyaBuWwyZF5WfvkgSxxA=;
	b=lACoCYoCFqbf2krZRstoLFXM6nD62R+A6K3B4iIKC4iBHZluX6PA+qbmQEoEtw+lf1+G
	 8Ry86t2y/BPT3R3M18bRlF4rec1K5BBEkv0uleXvXydquH1vu5+uLv342Nh76nUhA1b0a
	 SIG+qqiQrD0kAkyHZcS58TcJdVIGC23ZKLKTJj2MqxBFlKPZfbCtSRJErNe7t5/mjSCTs
	 Oo0JJZOOPeHGOjISZBnjT5lfxJkMN1Rkjl4TcCsRb2tZlnU7rasSXEcIPBYSH8eMwFFWS
	 X6UvTayeNc+FyJIIb+phaHf4pt3uGIF3XfCbZ4bLiHFat2LBxYemFoxwIbwRcEJeL1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjRUcyAn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686D606A31C;
	Wed, 11 Nov 2026 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjRUcyAn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322FB1F00A05;
	Wed, 11 Nov 2026 05:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794376753;
	bh=Ka4FTyAvq+CRe6XZnT1kLUAzyaBuWwyZF5WfvkgSxxA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=NjRUcyAnf0nDdP1XtWMTwDn4X7UCndnE4FIOFCIu7Vgvjear0YLvHU0Kf4+YFmaIn
	 kJBZNYOLEx7AgSEWwvIiRl5yJ24J6qink2vjWt7UP8KBBqmaXM9L7CFvYwwcDFljn3
	 eqb/N4F6lcUW1Lrh4DYVt7HiXlXt2c59ZXOt0u1myAgiS9wrWGzO+Tq79GCYYwp1oF
	 jWecZ9IFEyWSgCOWk8poR0c2fIYT9jabBcF5nBbDQcJzm7d35uo0X0jaCwirggSpc9
	 MiIwtA/yzNsDokwHYMad51NO2ZkWOFlJ6aYJv4Z/roYaZPJQSEDRVpYDWtOb0O5gcD
	 6cUiv/Ox9V8hA==
Date: Tue, 10 Nov 2026 21:59:12 -0800
From: Kees Cook <kees@kernel.org>
To: Takashi Iwai <tiwai@suse.de>, Emanuele Ghidoli <ghidoliemanuele@gmail.com>
CC: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_ASoC=3A_soc-core=3A_reset_r?=
 =?US-ASCII?Q?td-=3Enum=5Fcomponents_after_allocation?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87FF4A7B-853C-466A-AB01-2D9137DEE6CC@kernel.org>
References: <20261109102536.357134-1-ghidoliemanuele@gmail.com> <87bj7yw9e2.wl-tiwai@suse.de> <87FF4A7B-853C-466A-AB01-2D9137DEE6CC@kernel.org>
Message-ID: <EAAF07EF-6B11-4EA5-A5AF-A7787CA2F196@kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 10, 2026 9:50:08 PM PST, Kees Cook <kees@kernel=2Eorg> wrote:
>
>
>On November 9, 2026 3:07:33 AM PST, Takashi Iwai <tiwai@suse=2Ede> wrote:
>>On Mon, 09 Nov 2026 11:25:20 +0100,
>>Emanuele Ghidoli wrote:
>>On Mon, 09 Nov 2026 11:25:20 +0100,
>>Emanuele Ghidoli wrote:
>>>=20
>>> From: Emanuele Ghidoli <emanuele=2Eghidoli@toradex=2Ecom>
>>>=20
>>>=20
>>> Commit 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the
>>> devm_kmalloc_obj() family") switched the snd_soc_pcm_runtime allocatio=
n
>>> in soc_new_pcm_runtime() to devm_kzalloc_flex()=2E components[] is
>>> annotated with __counted_by(num_components), so when the compiler
>>> provides __builtin_counted_by_ref() the allocation now also sets
>>> rtd->num_components to the number of allocated slots=2E
>>>=20
>>> snd_soc_rtd_add_component() fills components[] one entry at a time and
>>> expects num_components to start at zero=2E Starting from the allocated
>>> size, for_each_rtd_components() stops at the first, still NULL, entry,
>>> so the runtime has no components: they are not probed, no controls or
>>> user-visible PCM devices are created and the card registers empty,
>>> without any error message=2E In addition, each added component is stor=
ed
>>> past the end of components[]=2E On the tested board these stores still
>>> land in the slack of the kmalloc bucket that devres rounds the
>>> allocation up to, so KASAN does not report them=2E
>>>=20
>>> Reset num_components after the allocation=2E
>>>=20
>>> Seen on a Colibri iMX7D (simple-audio-card, fsl-sai, sgtl5000): the ca=
rd
>>> is listed in /proc/asound/cards, but /proc/asound/pcm is empty and
>>>=20
>>>   amixer: Unable to find simple control 'Capture Mux',0
>>>   aplay: main:850: audio open error: No such file or directory
>>>=20
>>> Tested on that board with v7=2E4-rc2 built with GCC 15=2E2 (first seen=
 with
>>> GCC 16=2E2): the failure is there without this change; with it, playba=
ck,
>>> capture and the codec controls work again=2E
>>>=20
>>> The root cause analysis, this change and the testing were done with th=
e
>>> help of an AI coding assistant (Claude Code, Claude Opus 5=2E5)=2E
>>>=20
>>> Fixes: 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the d=
evm_kmalloc_obj() family")
>>> Signed-off-by: Emanuele Ghidoli <emanuele=2Eghidoli@toradex=2Ecom>
>>> ---
>>> 4dd10fbbeb9c only reached mainline in v7=2E4-rc2 (not in broonie/sound=
 yet),
>>> so this is based on v7=2E4-rc2=2E
>>>=20
>>> The other devm_k[mz]alloc_flex() sites added by 4dd10fbbeb9c were chec=
ked
>>> too: none of them fills a __counted_by() counter one entry at a time, =
so
>>> this one looks like the only user hit by the preset counter=2E
>
>Aggh, sorry for the problem, and thanks for checking the other cases=2E
>
>>
>>I guess a bugzilla entry that was reported recently is also related
>>with this problem=2E
>>  https://bugzilla=2Ekernel=2Eorg/show_bug=2Ecgi?id=3D222249
>>
>>My first gut feeling was that it might be safer to revert the use of
>>devm_kmalloc_flex() in that code, as it has a significant side-effect
>>unlike other straight conversions=2E  But, if this fix covers well, we
>>can go with this fix, of course=2E
>
>The problem is the annotation, IMO, as the counter member doesn't track a=
llocation size, it tracks usage=2E

For example, what keeps snd_soc_rtd_add_component() from overflowing that =
array? If you want to protect the array, add another member, say max_compon=
ent, and use that for the counter, which gets set at allocation time and pr=
otects the array from indexing beyond the actual allocation size=2E


--=20
Kees Cook

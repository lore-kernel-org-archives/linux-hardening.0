Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504829;
	b=XTunnNNbgtqYhMZtgjN1t1hr3q22DEpJ7+HNr1sFAjHXpGkix8u3togUiIXp1MoSEl7Q
	 zEtEFssaMKQV54T17yGOAQRMoSeUQ1siOP5NnbyLDLBfX+C2QErRioDE1htLXVoW/cJ1f
	 zxd+qwBTechU5rO2ssPUVl8s2pT2YvjUN7CWBIvbvWs30PD7cEd9UXjS63ET8IVHGrwYI
	 r+udXppmoNocJFEL4MlhXWgj9nVRLFXW+Lx4Kwzz0qwjctrAlEbY8RWXBMnY3Q1DXDbV2
	 VaA/OgLhY0b7lpQZEiBHpRVoSMkTp6EV0agm3t9bFfkBHGviSJhbWwVbTbzfkS0glHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504829;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ycakN5YjUyMtm7P6Yc24ptE+AqG+iCzKA8oeWY6lkDw=;
	b=qEANkeF7y3ZQ7j8YIJi1Z6qBqJfUU07yfyO+7gyU7b6GnRt3bBxNzyc2N331zeWNhPxo
	 TyETj34UzBpPapsA+j7Eo84C45zpnkhn+ZFG3tFYkg0oMvMOektYQK6ri49awTDWnE07q
	 Q6LsDKoCHIQLvdseu9BlfPO/7+Yc2MfHCOD3PeV0iy7NRmRSbRzc468uU75uiagndZPcV
	 alfQROBR9+HXiRLZAF0zusTBq0M9u4FoH2sUSHTb5ICF//EegTOjGCEF7YX/A6uOARpG/
	 h/85Ox/cvvMMUjgTT414fKDe4VRVT2WbALzEFrxNMwNTtUe/4Ul2auPEsawydwNEjrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Eg25RM/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB08606A327;
	Thu, 12 Nov 2026 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eg25RM/I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9759D1F000C5;
	Thu, 12 Nov 2026 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504828;
	bh=ycakN5YjUyMtm7P6Yc24ptE+AqG+iCzKA8oeWY6lkDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Eg25RM/IVsGXwrk3RjJVO2Lf/7Hd8Lkd1P08UHbytrg8EB00XhzP4OxIMdEQl+P1c
	 DsfHioxgNAuM+ersGyZIrmrRVnZeLtnGsIZfzR2JQ8SG6il2Y1ZGK/O2jPgnumTAxs
	 X7Z9Yr+zJIleUicK6ozTcmUA3F31bO/PMPIHxs/XZlNg1NFOha7j6kxQqAKCKgh8L2
	 Xf/DtfYI6ax/1O8rsUgNG0nHntQ40AsKJPmlc7Q+3kEp1qDHoZDP6IWZeBFFhfaB06
	 EWjq5UnOJo4QftxMnhCtUAbdnVKzOlEdxTO04ICqfgIBb9NW8rkLrrurenyHVFtz/1
	 uTPjAYQEsL1XA==
Date: Thu, 12 Nov 2026 09:33:48 -0800
From: Kees Cook <kees@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: reset rtd->num_components after
 allocation
Message-ID: <202611120930.442D702AF@keescook>
References: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
 <87bj7yw9e2.wl-tiwai@suse.de>
 <87FF4A7B-853C-466A-AB01-2D9137DEE6CC@kernel.org>
 <EAAF07EF-6B11-4EA5-A5AF-A7787CA2F196@kernel.org>
 <853110dc-2ab9-4271-9e81-20ce5068ecc0@sirena.org.uk>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <853110dc-2ab9-4271-9e81-20ce5068ecc0@sirena.org.uk>

On Wed, Nov 11, 2026 at 01:09:25PM +0000, Mark Brown wrote:
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.

Yeah, this is a standing problem with K9-Mail, which is what I have on
my phone. I only use it when I'm AFK but I need to reply to something
urgently, such as when I break what looked like basically all soc sound :(

All the other android clients don't really seem to measure up, except
for this particular gap. :( I'll try to remember to manually wrap lines
in the future.

-- 
Kees Cook

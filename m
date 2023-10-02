Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB76EAE4
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 10:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06359C433C9;
	Mon,  2 Oct 2023 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696244394;
	bh=lUBPNIWpDvjHX8I98WirEls2JkxV4/o074urcrO7lc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uFkgOuEtIDIjXaSSXt/PFQcRlOw/GbqlZHzhVadAKGoQmFEXk9IuDCnVku7/bEcOt
	 V8lW3oZ23trVQAcoS5oIS8hmtzQqrmJzT7SROtNsvHqFN1grInXjiA/TuYqXx+EqLT
	 nkUq89SORBvYg6mVUw/I8GYplVJNNGYmWP+PrwnFCzvNk8OViZCLMS6JsjaRgmL2uC
	 blJoFRJq1l+z9KVP9rEm8ZDiofm8lkggAPty8ezQPlbub2Bpg/Ypp5oyqbAc3kQWA8
	 AlcsUBM56q+yklqUJYlU/Jict4HTERCmkaCPvHCmrVz4d9xW+rG1Ji+hXgXKs6aXwK
	 OINs6zWiFd6qQ==
Date: Mon, 2 Oct 2023 11:59:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: ipc4-topology: Use size_add() in call
 to struct_size()
Message-ID: <b5e0bfc8-88cc-4428-8554-66b4da9c9acf@sirena.org.uk>
References: <ZQSr15AYJpDpipg6@work>
 <169601489953.3012131.13922425518082792309.b4-ty@chromium.org>
 <ZRlJN9qVOv7CIu1N@finisterre.sirena.org.uk>
 <202310011335.28B55A3BE@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jHjeUkQ9vroTCASR"
Content-Disposition: inline
In-Reply-To: <202310011335.28B55A3BE@keescook>
X-Cookie: Postage will be paid by addressee.


--jHjeUkQ9vroTCASR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 01, 2023 at 01:37:04PM -0700, Kees Cook wrote:
> On Sun, Oct 01, 2023 at 11:25:59AM +0100, Mark Brown wrote:

> > Why is this bypassing the ASoC tree?

> Hi! Sorry, I can drop it if you want to take it? I tend to collect trivial
> hardening changes with reviews that haven't been otherwise commented on
> for at least 2 weeks.

Yes, it's in my queue - 2 weeks is really rather fast between people not
being available and waiting for driver authors to review if they
normally look at things.

--jHjeUkQ9vroTCASR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUaoqMACgkQJNaLcl1U
h9Ba+Qf/dXs8T5y+jACKhiUt2Q8jXwBJIZcnab5H86E5MOnONXQyTG+rozhIbvdQ
5FibdLoYXrDu+EbviyhKagsSr0D4fDTPUvKubBR+DXOjVDWMcaKW+bVQTXHa428T
xzsMvPVvjVOlmA8vPux7nv26XtV0HLuJE+Ym2EzBlqFiQefjbb+6pwfw5/ZbOc/s
6DKIpT1kWL8cWb3zlhHsssQhnS5xVj+3qGb77NjiIme07oBr4Vl6PJW+6Nt+HrIy
GrWfE7kVfTHb5ph7OEesv68rG7bkEcsz/l7KP10XwjBMO/E6bCyqzKum3iIBxhWg
OSFTopV/X+x+PWLesMM5w7oenKni3A==
=qPZ5
-----END PGP SIGNATURE-----

--jHjeUkQ9vroTCASR--

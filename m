Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794036957;
	b=aGM1uoBfayt/h/ZT6UOdQMTeDaoDxQauzFlpXBPnsHZpC3d1sNHd8puHaveE2G+5GPQD
	 CtMK2g8gYYf+gzfsx+EnFeXNw2G+x58WpkqnocUI67F/eFkTdVjAFsfDwaWCpR6yVfCco
	 4vwm69ud8Q9r6xsFKMCHJOJCsxw42NvZTxt5Gt13E0/mC7s2qeqzkRlPsODW800BuebSp
	 1g0rTlBrw9NxR8kOHnYvOE5ojNcCnSO1OyI1ElPkzvGf/6d7foiLCFSV2picFwlzhBUml
	 qZZPXJ+UMB80GruNlE2uwv4vOeStAp6nyGucOeGSuu/tdnUm3DTrhuoxImPNhhfrU+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794036957;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WAzCgNZKBTWjPlBeFKE/F3eQLjhrgzmmL+LfzvVX5n4=;
	b=4ftWHnEvthyhY780iTCzer3l4SE0GfFJiBdXfE6kWRMqH5s2/wSVjBkmjvh8BqxjBBpl
	 OVyN/2Xg4fKDPE+98qvBDriIms+p8/UaLOjTvM6CtcirNZd3nmQbu3as5XFt0xs52WCgO
	 c2953hOKa5Qu/0FKL1szTTmQ6xTGZkMdMk3guPgC0IcQ09Vlo5S+TsXmymxyxpSsKiwo1
	 /E+3S0ChV+pH+l6HCQt6B7LyJ9ow7YwN4YYgVS3OrcKexUzhWj6JutrGOyMCrro3DlZAc
	 K7VtWw4h7Hnw8FUruNbyAslOYCII2+nuTFEouwT+1ztPqLZ1QpvXxpP91uW/4DQGTvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfUK0ujl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA794606A326;
	Sat,  7 Nov 2026 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfUK0ujl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BB41F0089F;
	Sat,  7 Nov 2026 07:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794036956;
	bh=WAzCgNZKBTWjPlBeFKE/F3eQLjhrgzmmL+LfzvVX5n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IfUK0ujlPNI/LqH9ULhlz+oBPZoEKtQBpgxephwN/EM63gbK6PviJNqaRnYr0sBER
	 CqsXUT1EPlt9PmUOTk2tNKOv+tep9a9L9vbZ1GyuJ3anFscgrUyW9U1xq3zoLRE7lb
	 P/TkIHyyvRFXPfE6+75e1tDYdq9fCn0QMa9dIIlzcf+cSgxT25SIgPpmi4lag6zFwR
	 lIAyQOM8vlbPQJXyikqSH++qSfjw9fHzNXg2BgQcwRWyZtTeSPegNV3s19yD/dCwbq
	 wSlPG+r8CtiPkZyovmKeQGFppzMxpigBJZ2R5bVHNo5imeHYDIZTQgSgk4Sh2nDWVB
	 2HLeS68tNtC2A==
Date: Sat, 7 Nov 2026 08:35:46 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com, alx@kernel.org, shlomojune6@gmail.com
Subject: Re: [PATCH v4] media: siano: Replace strlcat() with scnprintf() in
 sms_ir_init()
Message-ID: <au7Uqao19mXJ3Sxy@debian>
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
 <20261107033928.13891-1-nikitash.mariiaw@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sde7f3liglqt55jr"
Content-Disposition: inline
In-Reply-To: <20261107033928.13891-1-nikitash.mariiaw@gmail.com>


--sde7f3liglqt55jr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com, alx@kernel.org, shlomojune6@gmail.com
Subject: Re: [PATCH v4] media: siano: Replace strlcat() with scnprintf() in
 sms_ir_init()
Message-ID: <au7Uqao19mXJ3Sxy@debian>
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
 <20261107033928.13891-1-nikitash.mariiaw@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20261107033928.13891-1-nikitash.mariiaw@gmail.com>

> Date: 2026-11-06 19:39:28-0800
> From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
>
> In preparation for removing the deprecated strlcat() API[1], replace
> the strscpy() and strlcat() calls with a single bounded scnprintf()
> call to construct the IR device path.
>=20
> This preserves the original NUL-terminated output, including partial
> or omitted "/ir0" suffixes when the 32-byte buffer is too small.
>=20
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>

Reviewed-by: Alejandro Colomar <alx@kernel.org>


Cheers,
Alex

> ---
> Changes in v4:
> - Replace seq_buf with scnprintf(), as suggested by David Laight
>   and Kees Cook.
> - Remove the unused seq_buf include and local variable.
>=20
> Changes in v3:
> - Replace snprintf() with seq_buf operations after reproducing
>   the GCC -Wformat-truncation warning noted by David Laight.
> - Drop the previous Reviewed-by tags due to the implementation change.
>=20
> Changes in v2:
> - No code changes.
> - Remove the statement about buffer capacities from the commit message.
> - Add Reviewed-by tags from Alejandro Colomar and Shihuang Liu.
>=20
>  drivers/media/common/siano/smsir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/common/siano/smsir.c b/drivers/media/common/si=
ano/smsir.c
> index 283770d583d5..6952871c5816 100644
> --- a/drivers/media/common/siano/smsir.c
> +++ b/drivers/media/common/siano/smsir.c
> @@ -55,8 +55,8 @@ int sms_ir_init(struct smscore_device_t *coredev)
>  	snprintf(coredev->ir.name, sizeof(coredev->ir.name),
>  		 "SMS IR (%s)", sms_get_board(board_id)->name);
> =20
> -	strscpy(coredev->ir.phys, coredev->devpath, sizeof(coredev->ir.phys));
> -	strlcat(coredev->ir.phys, "/ir0", sizeof(coredev->ir.phys));
> +	scnprintf(coredev->ir.phys, sizeof(coredev->ir.phys),
> +		  "%s/ir0", coredev->devpath);
> =20
>  	dev->device_name =3D coredev->ir.name;
>  	dev->input_phys =3D coredev->ir.phys;
> --=20
> 2.43.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--sde7f3liglqt55jr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmru1NIACgkQ64mZXMKQ
wqmUew//VDubK78KSO3056TAIVtZgO00YEvcPiZHSZUhV18WTYdPDy2BRBEusEQ4
5NqgshxLjZbMKcdUCrTH3lUaKFud5SBFZJjHafjO4o0TNtCMX+C9liNDvFSXlbrC
CMiaQe3la6AexhGQ53ZZB0Pq19VLW+p9pR3j6XVZLhLQT1EMsuvGKfExrvzEV617
Q3lt+2hbxyF3oy6gqxyBBGIz9AHg105/yGXBMQPXEdUjtlRaQWCCAvZZPIWx/ebU
OEbWxfMs1dVYVXuufgRTtewcGDp5OmVjmj9TtCyh/cLPd+26Wwo6etZx+mLtcCFM
xDzCNzvt4woFsjY+YS2ibNYXOt3zAsRhIEqMju9wshF4de6X0xeiqQauKnBT852U
SkWWorP2086/LzqpRMESWhL0uKOoSxo/NnmpNQeEqXv1/vdaGrB2A0BWCFstMtLG
cpuOQB+ViSw24MrN8Sv+7Mip3FChVeoynBGcXONbvfvSN0dZ3lMXpf//W7wZzlAM
f4Iueva+Gk2L8+kZbnqj8FnFo/+wkK6nYUeGzgda6Z4Nu53nmasJst82+CDqqY9p
jmuTx93aM87YVJNpsDY0c/i5NjVOcLYYNlto6n0s/1hS9PNIRcOjdfVO/wztdqP4
BR7yGlumx+h5LfSoADQLrtNIeAu8pwPMPvWl0xP7QduTloZTsLw=
=jQzV
-----END PGP SIGNATURE-----

--sde7f3liglqt55jr--

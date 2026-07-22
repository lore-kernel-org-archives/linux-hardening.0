Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF05126C03;
	Wed, 22 Jul 2026 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732110; cv=none; b=SVP7C0G5xhkAMjRrRnqu6bLzIEJNsSof3GIEVkA6nrz6jOWEgvLAmdMywh9aJvJ1fYok+nSCaEl/HsEuglRreMYpOojDO8IfpECtcY2mJTZsZiCQKJsJ49q9uOfMu34kRJa/a5X2mxUjO3Am6Oe7aqIZI+sJjfOe2E5KoxWEFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732110; c=relaxed/simple;
	bh=1JY6zzWEdwWgXR8IVFy04xzVNLMT9M2zi53FUc9U7vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSD4JSNqD30ctT51hLEpt/BXuJRLTWBzairamMCMsogLkD/K9erV23zxTQtu75uQ6vwVP1g7d4G7BBclnfKobWLKwcM4UEzj8HU135rjxpg9DpoYZ7I8rW6myRkL862gutY/urnP4PBBWr5ZRx5XC0oeAS/nOwskoe+NhYJsf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Received: from [212.42.244.78] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <n.schier@fritz.com>)
	id 6a60d7a5-0463-7f0000032729-7f000001920e-1
	for <multiple-recipients>; Wed, 22 Jul 2026 16:45:57 +0200
Received: from mail-auth.fritz.com (unknown [212.42.244.78])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 22 Jul 2026 16:45:57 +0200 (CEST)
Date: Wed, 22 Jul 2026 16:45:56 +0200
From: Nicolas Schier <n.schier@fritz.com>
To: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Cc: nathan@kernel.org, kees@kernel.org, linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org, gustavoars@kernel.org,
	linux-kernel@vger.kernel.org, nsc@kernel.org
Subject: Re: [PATCH 1/1] scripts: kstack_erase: use relative stackleak plugin
 path
Message-ID: <20260722-ubiquitous-stork-of-hail-3ba047@l-nschier-aarch64>
References: <20260720093545.3836066-1-jaihindy@qti.qualcomm.com>
 <20260720093545.3836066-2-jaihindy@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BWw+TpLaC4TGsuXs"
Content-Disposition: inline
In-Reply-To: <20260720093545.3836066-2-jaihindy@qti.qualcomm.com>
Organization: FRITZ! Technology GmbH
x-ms-reactions: disallow
X-purgate-ID: 149429::1784731557-C67FA94F-DC71CFBD/0/0
X-purgate-type: clean
X-purgate-size: 3362
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: queueID: D90F5A02C1


--BWw+TpLaC4TGsuXs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jaihind,

On Mon, Jul 20, 2026 at 03:05:45PM +0530, Jaihind Yadav wrote:
> GCC records full compiler command lines in DWARF producer strings by\ndef=
ault. With CONFIG_KSTACK_ERASE, the stackleak plugin is currently\npassed u=
sing an absolute -fplugin path, which can leak host-specific\nbuild paths i=
nto debug artifacts.\n\nResolve the stackleak plugin directory relative to =
the current build\ndirectory and use that in the -fplugin option, falling b=
ack to the\nexisting absolute objtree path when needed.\n\nThis keeps plugi=
n loading behavior unchanged while avoiding absolute\nworkspace paths in re=
corded compiler flags.

Please note: while the patch below is applicable, your commit message is=20
broken ("\n" instead of newlines).




Can you give me a hint on how to reproduce the described behaviour?
I enabled

CONFIG_DEBUG_INFO=3Dy
CONFIG_DEBUG_INFO_DWARF5=3Dy
CONFIG_KSTACK_ERASE=3Dy

and built with O=3Dbuild but cannot find the path to the plugin dir in any=
=20
binary build artifact I grep'ed.  What do I have to do to find the=20
plugin path there?

[...]
> diff --git a/scripts/Makefile.kstack_erase b/scripts/Makefile.kstack_erase
> index ee7e4ef7b8926..006d10f3b77a0 100644
> --- a/scripts/Makefile.kstack_erase
> +++ b/scripts/Makefile.kstack_erase
> @@ -1,7 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
>  ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> -kstack-erase-cflags-y +=3D -fplugin=3D$(objtree)/scripts/gcc-plugins/sta=
ckleak_plugin.so
> +stackleak-plugin-dir :=3D $(or \
> +	$(shell realpath -m --relative-to=3D$(CURDIR) $(objtree)/scripts/gcc-pl=
ugins 2>/dev/null), \
> +	$(objtree)/scripts/gcc-plugins)
> +kstack-erase-cflags-y +=3D -fplugin=3D$(stackleak-plugin-dir)/stackleak_=
plugin.so

As Kbuild changes the working directory to KBUILD_OUTPUT build dir for=20
compilation, I'd assume that '$(objtree)/' should just be removed and=20
scripts/gcc-plugins/stackleak_plugin.so be the always matching relative=20
path to the plugin:

-kstack-erase-cflags-y +=3D -fplugin=3D$(objtree)/scripts/gcc-plugins/stack=
leak_plugin.so
+kstack-erase-cflags-y +=3D -fplugin=3Dscripts/gcc-plugins/stackleak_plugin=
=2Eso

Does that work for you?

Kind regards,
Nicolas

--BWw+TpLaC4TGsuXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmpg154ACgkQiMa8nIia
bbjjphAAnOpF+ulQC7wu0luyF+WASO/ZDV5/xNF6B+WCnNh8PI0w7EzFRJitUWEA
JRiMJuZ1V1qbXA4LLdALs+2xltuhw28ndWB5X+/FJaTCoI8DQe6H2dgv2wPOCph4
g4fPJmfTZEMV6z5CGgTpkAwJGKXR+62FDCYxlwuz6az8AVHN+XZ0YiR+PvVNWFE+
f8Fme+2/Rm2TZERQwg8KTYaNkMTbhz4V3PBBp5WR2Y/59Ien+X/peZCdjhqhpTk9
XKYrEOvHhP/COBdCMKPxMX25BDk+acuI+K5mSs3RfbXddGPnSpkufqts5ZGc2Yvf
YV6+PRztrCPIIlecEwLfEj8wKueWRqQ6GnGH/QQlEf/htOOP241aPRGA55DZj7oj
MYX3ssCdoQPXrPuTaTbYu1Ztwfz7ZRC4uHanQ31l+GaUyPUaf96IxdcaQZ4P3IwZ
2mHKmwtAUJGPaGc4OpH6af3bIbQvo6yT0hYP8mCF+TD9G+Pq2vetayII3aD7+Kpg
ClrJIssIJ1EAdFrf+89c7yFL613w2864eg5jnb5OQf/SCXscgy45Jie4Cekmgo3R
/TsaG+lzIl2Urk4ZmHhPIIceeQY8YHyyPfF+nnurDBKU68ntOR1Ks816sFb/g3RB
pApKzoPTbfd4pRNjLecMDSY638syUqpxNlIjgR7SQbxcYZPsZ8A=
=Zhdp
-----END PGP SIGNATURE-----

--BWw+TpLaC4TGsuXs--

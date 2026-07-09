Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC33EFFDC;
	Thu,  9 Jul 2026 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585830; cv=none; b=iyHuTpDjc4LhDEbeUj31L089NbGnS9b5JplcdixyPXDHBkfGu45n3C6d89+Pn18IMGG4F5IeNx7XFMlDW5FYqbh55iruKiFCUDScAT2oaAOjIeTeeUye6qlGG6Kvzuo7feaWMoT4nOB1UGU3We9IcfsXVd7T9VYW7zx5QIpUMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585830; c=relaxed/simple;
	bh=yrnx5HJIOowVMAtXafWiiy2MksnqCSqlQ/csYgBxAR8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FKZjkfEi/tmoCqxSAYdQ97CfhDA/5BfOnQAaes4Ml5rSfFggVOG8zIe7QWLdHqNeuAUK00uhXVmlTENFF05EYalPGYlawK587ojxW68YaoCCKnCpsJafRY+LpA0uiHEnpNQhVkW2kP5LObECGkrHkaUcdRxem2AFRmyOT+skBFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bruR3gxp; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bruR3gxp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783585826; x=1784190626; i=markus.elfring@web.de;
	bh=yrnx5HJIOowVMAtXafWiiy2MksnqCSqlQ/csYgBxAR8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bruR3gxprjSmpQr5q6MOaMfIwTUqg6uzPCWEHSO12YdkN/Y05vdu+eNfFRFudHXM
	 s4jpAG4YkjSC5OGKkHJQSX8kCCFNpZqOy/5QtYfhPJqhfNt0InIxX2M2lXxP862wL
	 V9VbBf96DHv2EMnXD6j8U58xOnyjQr8TAQuSkt7whSpuxM8MY/lSNFeoRwAIJ5sp7
	 LbuoDX0kl+gB5fpMi8Q+l0UKDcpPbE9RhblyGpbch1qDLW+aysmOUqrSes990xB1n
	 hTlHqnpkedpxqcFjgiAqtbX+kY2XT8LDx5cXaBTb0un6NgPzLaECHqSimRk/r2qx0
	 M0OVz+75Iw0tW7H0IQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsaRt-1wwNis3xvf-00v5hu; Thu, 09
 Jul 2026 10:30:25 +0200
Message-ID: <9e874fa0-d8d4-4c67-8f4a-6569a9a31525@web.de>
Date: Thu, 9 Jul 2026 10:30:15 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Avoiding selected variable assignments before null pointer checks
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 linux-hardening@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <d7a8e34b-e490-47fc-b892-886e1c799c4f@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <d7a8e34b-e490-47fc-b892-886e1c799c4f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FfYT6y57iTUAp0VL40HmJSE4uEVNDRrQqz5dSfIRVKwDAHfX6yS
 e1+2cGllgj4aZKtHd4Kvn7ys0s6GWU49RFUdKr2Sam9m0/rkH+o/4qz0eaqCA48w6nE7G5n
 ZxqZxktezPY5ChHs4FcwIVcr+4iM6e7ypyTHdTtu4Pw/KXqN2VXMkQ+YXoUd4kgQWLlKLZT
 f7Px9x/ysv0A19dOCMqkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zwHsYADiugg=;nHGbTMNSb3rnm6q/ZnWSNii0QdM
 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

=E2=80=A6
> Test result:
> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/b=
in/spatch --timeout 23 -j4 --chunksize 1 --no-loops -dir . =E2=80=A6/Proje=
kte/Coccinelle/janitor/show_pointer_dereferences_before_check10.cocci > =
=E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/show_pointer_dereferences_=
before_check10-20260701.diff 2> =E2=80=A6/Projekte/Bau/Linux/scripts/Cocci=
nelle/show_pointer_dereferences_before_check10-errors-20260701.txt
=E2=80=A6

Which factors do seem to hinder to achieve more desirable improvements
also for such a source code search approach?

Regards,
Markus

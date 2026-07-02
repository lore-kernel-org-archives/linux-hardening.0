Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37623A6B82;
	Thu,  2 Jul 2026 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016838; cv=none; b=s3+IAfWNAukrchFL/ClPxqOR4uK5GzKG5Ozkn9FTLKNZGrx36/bTtJdvNrdpS11S8GiXyn9UqReAIh78uiVFYR90XA4S3ZtBTtsC/ypGTVE6lPKyjy+YzM3uOhHQsoZ7YFqXreZbcgyN73OMVM74zM2cTYZhILYJ165ujBx+zYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016838; c=relaxed/simple;
	bh=emJSRFPdZfeRdhUZZbNUsjtssMuTvCr6CVZzYVjzfqA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=c08cXrzu37UHLimcfj7DQ6rBi8JlLQ/bCc6a/29g/zOTzqIGrSpuxm0EJRpktciyDQIn+hG3GF5PbFW8AbV+qeMdJJ03VBkrR3cZpeNPI1BAwtXZdKaITfDuca1pznVUM2Qzy1X/HDQN8Ehm7n4mRvctOWFZNmtMSDndOXAl1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JjlMZK9Y; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JjlMZK9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783016827; x=1783621627; i=markus.elfring@web.de;
	bh=fmnlp0eX5iXTcBkQJ1PKS5DaPVoZ4pGbVkWZ3eHBmk8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JjlMZK9YhaHQR0caqvRhYolN9UpTiovdIbwvP3xx03cXrIIdsKFz9NS32CqxSu1S
	 oNuTziMlc9icrcxDNtGU81GDadCNgfX2VFYqvppaFPAjKeUQ6gw1yOpLSD7mu4SM7
	 ug5DAITZ8Ezvy1yfUvieiIfvfQglbAToRy+iv9d8sKjH5VRMeea8kC2k1Blx9TMiS
	 HoX0oylb1ihReKz21PxUU55BK7y+w+HpWn17MeV/b+7+ExZzO7FYJUTOzc9PkdxZX
	 /BVNcmPbrkalAQkAaHGfvlgJn6bSUdp4iTDl2pu33qoAIp1g4ixmO3Pobfs0Cfl+7
	 cGWo+5xTZZwgkBdM0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MV2OY-1wUwF337tG-00Ybny; Thu, 02
 Jul 2026 20:27:07 +0200
Message-ID: <d7a8e34b-e490-47fc-b892-886e1c799c4f@web.de>
Date: Thu, 2 Jul 2026 20:27:06 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Content-Language: en-GB, de-DE
Cc: linux-hardening@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Avoiding selected variables assignments before null pointer checks
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qYIvxh3cl9bl2lsiEKon3vkw1vjXZ8dkRFGTcdH1bvEea3DSmda
 NF+fRBeQ90ZU59PcR9GgedqSy9GFgCkU6Hb1y8YKatJK5Pp4tAGmXeoHOZHdg2M70pxzjqC
 Lmw8i/lLapETQZDmMByEIEhuWyx6BaEOJODcyIOlf8m0rWY3UUB9RhYAhcdvqk+up5PD/+D
 uZRpHeF0CGPupm09yzIXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:koi5dAw4UGQ=;c8oLNc9S6a+/I1Z478RuXrXoMqn
 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

Avoiding selected variables assignments before null pointer checks


Hello,

Another source code search approach can occasionally be helpful also by th=
e means
of the semantic patch language (Coccinelle software).


Example:
@display@
expression action, input, target;
identifier member1, member2, var;
type t;
@@
(
*t var =3D \( & \( input->member1 \| input->member1.member2 \) \| action(.=
.., & \( input->member1 \| input->member1.member2 \), ...) \);
 ... when !=3D input
     when any
|
*target =3D \( & \( input->member1 \| input->member1.member2 \) \| action(=
..., & \( input->member1 \| input->member1.member2 \), ...) \);
 ... when !=3D input
     when any
)
*if (input =3D=3D NULL || ...)
(   return ...;
|{
    ...
    return ...;
 }
)


Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --timeout 23 -j4 --chunksize 1 --no-loops -dir . =E2=80=A6/Projekt=
e/Coccinelle/janitor/show_pointer_dereferences_before_check10.cocci > =E2=
=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/show_pointer_dereferences_bef=
ore_check10-20260701.diff 2> =E2=80=A6/Projekte/Bau/Linux/scripts/Coccinel=
le/show_pointer_dereferences_before_check10-errors-20260701.txt

real    32m26,907s
user    105m10,515s
sys     0m45,265s
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> lsdiff =E2=80=
=A6/Projekte/Bau/Linux/scripts/Coccinelle/show_pointer_dereferences_before=
_check10-20260701.diff | wc -l
44



How will chances evolve to adjust more places according to remaining updat=
e candidates?

See also once more:
EXP34-C: Do not dereference null pointers
https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-standa=
rd/rules/expressions-exp/exp34-c/

Regards,
Markus

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237CC3AA504
	for <linux-hardening@vger.kernel.org>; Fri,  4 Sep 2026 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514895; cv=pass; b=tuwesVZwt4sLGlXgwO0wVBKTWn5B+AGKqRj4J9LFfYh+QhKxkux2B1CLy6qoV/ecsXblGq0P8q8KUOhnrZuPHPXpTZyaO1kxHL3jG/VLf+E89iw3ydwasz/hTDpqaaS0t1D8VkatuQ3hFM+hjKpPU1N4vg0j57Nzx54k0fzN79s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514895; c=relaxed/simple;
	bh=aeIbZ7Iqe67MQUbdL30yfOYMS5DGGUDI699nLrKwSTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCOUvkNTB1M6mhj+Kp2JsYXXBdv6fqNDgGILGxP3CROliZGWp9zEw1nukwM77EIOi/gCNQsbTvCZDmXGURy0jczl9WZbG8iSgPxP8Cb1o415pl1x6jiThkfoLH4vcJEmbHk+1boaA6kRdsluoWTTLMd/Ck02g19Q8eQGu7Zaqcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i72Z6a9K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A8Ihag5g; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i72Z6a9K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A8Ihag5g"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mmJH3234634
	for <linux-hardening@vger.kernel.org>; Fri, 4 Sep 2026 09:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VI7GobWclG+P/LAGHzs6kL80cH1L+yzTiHPraa21oAA=; b=i72Z6a9KXUf5KnGC
	BQonw6JeT+Vjv4bONkiN5R/yDVYIy4owVbuOPcViQ2rgdsioq3JFpI8fDPff+J13
	SBrDNXi2c6ZJBU/55j5rdEWi4AH2gMUk7myZfe2KJ7yq/lQENXcTlmOrHymAn+RK
	1okxZnHiy9mF9JRuYYCZeD69q+Fsnt1HOUvM54W+heRsuAPKud8Rx0TmUng+bLcz
	t2NTi0363Uz6ckoyx2DYmRrDG/oKK0BRouJUiOBIx2ctjEScgjqdClPHa9c15Ht7
	X0fE0Uykud3+DQLIg9Lli3VWMrgxQ3S3RLfgdNEwORppGHKokMOvEmpLAPtM82bm
	+g1k6w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp0r1472-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 04 Sep 2026 09:41:32 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-85321e37104so1054101b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 04 Sep 2026 02:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514892; cv=none;
        d=google.com; s=arc-20260327;
        b=sWk90i+pVrQAYrWw6Svg/vO9dvE9+xycmQvVuI/osGbN1B6MSoLvTNpIzKa8whfOzz
         cHEjf5lzg2iWhUhdOFoz7HSZkdmHmbgHioDnnpO7O3UBfTsmz7ZceXK19RLAoUGQqhPj
         D4qO7asRLEQobnCz4FkyWDPKfM1zUjnVPg1SeI7uoc2v7WT39+QbwDQN/DQ7fJ+71sTC
         NGYTGISGOWP6vBbaWka51ydmxFTm85ZFUoe6yPPdodT9D9BDfzVJGvInicWQcl5Ideyp
         rCT2Q7auCK/EFx4O2poSk9U/iJR1JtLxS5EYbGNT307bZbj1yHUiNe10XpjV8hRXm0Q/
         SXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VI7GobWclG+P/LAGHzs6kL80cH1L+yzTiHPraa21oAA=;
        fh=euXFVR8yZUItLzc0NtJuJWV9BOzgN89xxOiXwODQwWY=;
        b=DYtV+oV+NEKgO7svs9B2Lp96wsODMUBIXGne5pV7Nf39CVLBSQ606LQiR4cqR1waV7
         /0PP28EU8E8hFXTQ+m+cvGi7HjjrDkOcmWgeavxAKaiYCwsy2wCR8MvOLdDCG9eKHbHP
         XP7IXSo2+5UuHEKvngU9Tp1il7W1//QGUci3Mc0x6quIs6geKp7L4NUk1KEcRj9/NpZX
         HTifR9LZ4kKBACExnBtYe7A3EWkAXA/oek0ENQjVZu+Rb5Y3m/9rU6GHJVjGbFKaEWgE
         gyK11p9VC9fS00IUAF7Iwei4wxPMkPYjOKeOP5Krcl4GfoF5sfQ2NOs3u0z4uoS/k4Ev
         MChA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514892; x=1789119692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VI7GobWclG+P/LAGHzs6kL80cH1L+yzTiHPraa21oAA=;
        b=A8Ihag5gsM5mseZmVs/nSzeGC4ZbtJHkUSDmWjug3v+SEjloN0mP/eXWqtyUgqm0wG
         DP3BD0MDZgL807UPOr1apyvtAIR+IYCOsyAHf7lDlap2b4UB09td0k+YjmIF+w5aGF5b
         tZDX99hCfyyaBsm9FGiLSEVZe5HmXJxwCkdrDfny2ZTJEtONQQPSp9rC5YihI/zuiRC7
         CnAqffipYLInuLwDrsKERAh5GUkYHOn1KiL5MB5v61r6cIUJPbIfA6C6YpC2bUAFnXai
         vMmcQkmibB4Ee79xU1b3/7LCdvHUflQ5P1DHjKDfzOg0DYEyLweidrKvwc17pT9vDWzV
         nP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514892; x=1789119692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VI7GobWclG+P/LAGHzs6kL80cH1L+yzTiHPraa21oAA=;
        b=S5ixgN5OUVIUQjDQHN3ybkLHh/bXarJN4bAf26OEJ/C1xEznR6mD2TdF47Zp1MOqff
         33bFI40NVARLqMkqYOofsZVXsFFdtkYMeU/oGQzcuEQQTLkn96orBM0Ub0+WoBA1q+Rh
         4QZPGOM8s49PRklHk5r4bCwbEwr+w/FuaN2rS0cv70p53n+iAx/WNjdVy/OkaTBhPJmc
         VZgXG0AYJgFRCFRiGgI1q0mPKE7lt67hohp7veCH7aXK/pM1BU0kCYeivZV7/1wl4jy8
         yECK3CejrbgaCeROm6dSbs7PcTJ6VQwqI9WbWj5qAvaP291gCJb7C5o5bRu9ARrRxdNh
         B9uw==
X-Forwarded-Encrypted: i=1; AKwUvBw839ASanNG+UizESeUnPFXMhRXkYnVIoc3vR1jUYlj+cD570FE/X6pkr3Vi+DCTagQvlAifCUfudUQ+4b7TYc=@vger.kernel.org
X-Gm-Message-State: AFuF++md9hXnDIkHkd6c++pAHUg9/aFtHswp1PVdl473XZyAE7HUkEp1
	wRMpYRREM3n8sKbu8QHuQoJslC349L+OwkcN2gbYMNhBGvo4UxYKPj/6cVDVUW3DWfpIoJ/Kwsc
	bJeMm+cT9J1+8VhIA7ML3mQKRFPDx33iLJSTNm0kpzdJvq2vtse8aqoaJNdcNjQ9reqmbrD1Pf8
	it+C7ov14JTaMIN5E5LzP4NmVI4X6rSNtJwr/0qyvsguD/7A==
X-Gm-Gg: AYBFou0wQWdyx1X2XOLSVue4OwghKnxlNCoB5d5/BRBpKy4tmyeBwwKhgK0FKVNgSSR
	FU8FvOjJGEmmJ53vGuvHLASbjIQugKT3E4DJLOyTZUI/PJbVn5on08plyJwwpJwwAJNkiefLCNd
	r2epuFO6W1EwZq21ZBqOUVKZc84VMosMQuSqx2DQEgYAOsgTGYTUUQKkBNWw==
X-Received: by 2002:aa7:888b:0:b0:84f:dfce:966b with SMTP id d2e1a72fcca58-8616a06b9eamr5822376b3a.8.1788514891638;
        Fri, 04 Sep 2026 02:41:31 -0700 (PDT)
X-Received: by 2002:aa7:888b:0:b0:84f:dfce:966b with SMTP id
 d2e1a72fcca58-8616a06b9eamr5822324b3a.8.1788514891229; Fri, 04 Sep 2026
 02:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608095523.2606-19-david.laight.linux@gmail.com>
In-Reply-To: <20260608095523.2606-19-david.laight.linux@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:19 +0200
X-Gm-Features: AcwNN1XghJRFBri_1kHjfvi2ey89ABXgLFgvTbim4Ym2LDpNCA5fwc7QdZp97mA
Message-ID: <CAPx+jO_btBTkL2Ph9rM6er8SZkSqOB1WmuHhtr5vGBXtwcWxRQ@mail.gmail.com>
Subject: Re: [PATCH next] drivers/mmc/core/sdio_cis: Replace strcpy() in loop
 with memcpy() outside
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX/zmHrymng3na
 9txWFiQAc6HL0RtY2KVpzKNnIw3D833yBJjOeoc4J+qVG4ErIEZyTrmVdnT3QKb1Fy+i/XmP17K
 mjBHNYyZMOafKCx4cd4Y4xv4WQEitOY=
X-Proofpoint-ORIG-GUID: g3lx0gh5wn28UpM-sHjDuUW-hYnva5iI
X-Proofpoint-GUID: g3lx0gh5wn28UpM-sHjDuUW-hYnva5iI
X-Authority-Analysis: v=2.4 cv=T/S8ifKQ c=1 sm=1 tr=0 ts=6a9a924c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=_2Zrk8i5Ywt6DdIg7-0A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX0MXzvZz9PppY
 fuqFBZpweVojev56zSjSPVnG2obtk8TTrOV9VZ/k/D5W0psXRtZcZs3kPVi+SFHGkF0vazeLKtB
 uxTu6XEltivMOkvP7/yVuPVBrjENYp2o7yldEkytfn5z94rd3uSC5+w6rCr8/5T6j6dkHHdfe2+
 EA0VpNiIayf5Pl6rB0tdqTHbuWcNvQKvfa2kiZua1FXGMtzcQj9b2yfXb6YV01kJ4/WZj+Kkx0M
 ZAi0an/fg4oyVJ7+x588dmRhNj9+pPMX9l08tZxLxa5dgT8T2K0m8YBLYAIbBc0G4BxmXAx3aQW
 g5VZLcK/Y7rzA0f2pkUWmdM86iseAUvAYxF+5Wam8bIbfY0J537rHetlUcFAxQdWF3bbijbllMQ
 HAZ3wwh902YT+L6jLFNRPc16uNg/mcNTL9vdTfaBJkwvTYFFvb6Qa7kqj1iV9dCWe+Mqa2WEgtq
 we8jItFJAXeZUMWrNJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040088

On Mon, Jun 8, 2026 at 11:55=E2=80=AFAM <david.laight.linux@gmail.com> wrot=
e:
>
> From: David Laight <david.laight.linux@gmail.com>
>
> When copying the info strings and generating a char ** list copy all the
> strings into the kmalloced buffer outside the loop and use strchr(str, 0)
> to find the next string inside the loop.
>
> Removes some strcpy() that static tools might think are unbounded.
>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
>
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
>
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
>
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
>
> Note that all the changes are only compile tested.
>
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
>
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
>
>  drivers/mmc/core/sdio_cis.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> index afaa6cab1adc..0b818cb478ce 100644
> --- a/drivers/mmc/core/sdio_cis.c
> +++ b/drivers/mmc/core/sdio_cis.c
> @@ -57,12 +57,11 @@ static int cistpl_vers_1(struct mmc_card *card, struc=
t sdio_func *func,
>                 return -ENOMEM;
>
>         string =3D (char*)(buffer + nr_strings);
> +       memcpy(string, buf, size);
>
>         for (i =3D 0; i < nr_strings; i++) {
>                 buffer[i] =3D string;
> -               strcpy(string, buf);
> -               string +=3D strlen(string) + 1;
> -               buf +=3D strlen(buf) + 1;
> +               string =3D strchr(string, 0) + 1;
>         }
>
>         if (func) {
> --
> 2.39.5
>

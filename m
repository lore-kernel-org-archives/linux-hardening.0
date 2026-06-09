Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73A48125B
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018139; cv=pass; b=XGxky71hAYDAuL3UUAQ6hGa+GgloKeQq89aoU4ltWscWyLvVfXeHtkLUIg8F/K3ZCJAdgd5sjHqFckeInE7X+COT9nX/KKA3B0emKsGkSKBCLDKKDBhbUGZly7z5XhhIZT5q/DArHhtrE/3mCNgYcC8DpxXkdUhkg7c+LIjeYG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018139; c=relaxed/simple;
	bh=f1j7iu+o5kZq++XxgNCC2TIdJygR3iwb7JsnnVDK8I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fn1aPVc2kE+eBwGNG29hdA3RRvjvu6dIguHnXLz+6/ZXlwi3k27NihW0So1HCRsleToq7swu+x7KTU5lSvlbQLGexRDF3otcbb51tzCpUY+XHDX3lUmGj68qPzz/IfXw8MsPK26XPM6XQL7yzyzQ6g2yAwV/3yy/R19agNvOe/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROnEOxsA; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROnEOxsA"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68bac6e24fdso7651198a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 08:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781018133; cv=none;
        d=google.com; s=arc-20240605;
        b=LWLKeyVRTIlPBf/2Fx2CYm9+H1qmkLPIuAMo9aWs6iANvLSiWaiErg1mDkNKIKNh1y
         PkYnsxHybUapR3fYxZmV4a322gKTTmKovtCvPQ2OCz0uvJZA8TcLAXEsytCT362YGlDI
         rwFI3vPzNHs5To3vYqAQcwmrF6cb4rWxq5rFks11q/VBlZbPgg5xoLWViMDy3BBPJKvn
         97RR4pKhZfqU+wY9DqmZyLUZ9a+gOkf9xiD3/nSfrIRPuY54pwlg5ZFeIq231Vp3nXx4
         b2rIDKN9kxxg66J5xRRP1MhmxWoEubvW0hRCKUaJvjOMrDXnvgVHoRDnjaS+s/lbbDu3
         NCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f1j7iu+o5kZq++XxgNCC2TIdJygR3iwb7JsnnVDK8I8=;
        fh=2CyfrWsq7DNtbDO4iT/WjQBPOxPMZZwTsWdcY8bpb2k=;
        b=jza5QLOhS+LOSu29Ba135l3NAQst3KKtBHVWYL7qk1BN3aY0nYY6GcBmAUNVQSytOg
         FTFt297MXzWSCLDtIufx/MKMEoggKAnH6s7dB1wz6Mh4+yZ8MHkbBTnaRznQZO9nCFXm
         iaZ/B6OMoP1dwlntgB4ZB7F7aCsSKrQ5O4FSAfcdLmoQZ7QTi6na9trnlifUovjgwNYX
         Pf79rQGrgsgQdAcoEsi2xVHRSErzKpivknmqUhmzso3JozG95RJkEJe+VHfcebh09hZ1
         pJZnaGdHDJnGhFl8ZXBgp4A84u6VZ1UeXBG3huQczOBgYBmpfTLLQkF6YVQrM3/CeKtV
         RmIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018133; x=1781622933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1j7iu+o5kZq++XxgNCC2TIdJygR3iwb7JsnnVDK8I8=;
        b=ROnEOxsALENQKer6pwqR5Pi6AY9FW5mhmD391bWe1k2/P6FM5CuCm7YpSruXaPsXYa
         SVXNw/hEYfn4HrViA8JArFyCEknOBOCpklb99bXJFU7P7vWwkt3+XwrqQv31GxhBW66b
         LIVPBY1fkuqmrGiwnpOrE9BwboM2S2YV+B1DZsEMbH/N5LeJ+ZTJV7bDcv7j1SSUAPQv
         Adix8/UdZ8xIzRiH3FeB2Tuo5Ak968lw9ZSAmYyivOUcM9jgjx2vj5Lu3Kl6w2jyYSae
         zjKO/2qUkX0A8qesAcj9Tmf7zisyW07svGgP/zbGChhxc0PgrvrgDMXIhg8Eqbd4d+jX
         xMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018133; x=1781622933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1j7iu+o5kZq++XxgNCC2TIdJygR3iwb7JsnnVDK8I8=;
        b=ARjO+fSYukEkftEz6PO9AiAP4nfjqzFw5weW2R/37Z3kaGnfBYmuUMcOk7fdyl78Y/
         4mHLoQ6py5hMiqyESvDbKTY5mRJVyCoiMWmW80A/ankdvITh9J7ilgzlX9FFfXpBn4x2
         L7pbzmrAt7b0Pd4Bw1jI6a9Vd2wPqxAjOiT81e9bm/GrihSvQJsPpNEr6oS3UQ54BMtZ
         Wa8LHxZWK3W5bNUCFbqaNeWmOtxswwluR3f/UFM3aBN7l1OfPeQgxKQ0PT/qSgC640kA
         qOIlpbDK6MI7rDPBrRXp0xXxe7UgCC94VLYaJ5u8ZwFV34PtoYXJuVnLRZzopdim0AVT
         dYeg==
X-Forwarded-Encrypted: i=1; AFNElJ97CggbBquZyP42x8ext5yt/ytkJJViZEa6YNa2N6OwxIJLSYkmzDLrMQTZ/8FmObiuU5W+2t365dLNOihNXhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXB9HeB+gfcGTz6ythONt1WcodxJUg6yV3esjVNgx0OjbUHw0D
	ss27Km2HJ6X4UZ3aBQIBZvcpcrD2wlLW/IOqTFI1xGCJscNO2y/NKSwQDkQ7kc0ZjZrF65Pkau2
	/F9rlfjzA+LstX9KpP85c5tfHWPa5fgCkiPrpSw==
X-Gm-Gg: Acq92OGIGFjfzGqkvpEX42QuWTbjBO319yAuPnbEwt//R4MMr+ANsx4ICAD7l1pNmKg
	xCz0q+eu/J6/pL2w6gkaeEHN86vGeFgaJvBShw0o8Xl6PD1aFXGLCy5jRV9v9eLa0pIjsOFSM71
	/BGSd+MrZn5YgtvXqTswu56GxlEljWZEUpB+WC3KbwZoKAeuuYFRJFgl/mnAtG8Cadil3yxWYle
	2QcJOXCZqV6k8n98maz14E5B8lCtoaAbAtQfstoFVeWtdrCEzJNS59k1UJg8RaavGO9DaJD21wv
	vnQfCq6vf2chiY+wypS9+Zm1LE7MHr+XeTSiePLZlSo2F3fwkziTaFp6hpwzQ0vydkykTdMIfq/
	vYIZuemyaKEr/BSU2IiZmGZ88bYUq
X-Received: by 2002:a17:907:2712:b0:bec:5865:6c63 with SMTP id
 a640c23a62f3a-bf37234ab8dmr718710066b.26.1781018132938; Tue, 09 Jun 2026
 08:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604125034.13757-1-med08elkadiri@gmail.com>
 <aiZDlSTqaQTcvLBl@kernel.org> <85a686a6-7fcc-4a1d-8574-0fc7c2f84bc8@kernel.org>
 <aigoZeoqygyBYCbR@kernel.org>
In-Reply-To: <aigoZeoqygyBYCbR@kernel.org>
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Date: Tue, 9 Jun 2026 16:15:18 +0100
X-Gm-Features: AVVi8Cd53HY8Byh_1TfSIUUalquq_E9RxBK_dmxQm119rFisNv4Tp0HsicGdC1I
Message-ID: <CAAMeuQTue5bkbhjYLjsRCnB9=KBifsPNQ=ZRVp+wCh2TiXE7Uw@mail.gmail.com>
Subject: Re: [PATCH] keys: prevent slab cache merging for key_jar
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jarkko, Vlastimil,

I will send a v2 this evening with the commit message reworked. I will
remove CVE references and frame it as hardening rather than an active
vulnerability. I'll also drop the inaccurate skbuff_head_cache
comparison that Vlastimil flagged.

No need to strip it yourself, I'll have it out today.

Thanks,
Mohammed

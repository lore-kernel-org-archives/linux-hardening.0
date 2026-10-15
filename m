Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D194A7C8B
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050472; cv=pass; b=q3seLqpQi9z4FgClSIp4ggcaFOns/kwt5eNO/TTZC+UusYog55UkjisoUBJqL+5PX5EjDz/jZNNDwiJkOe+AuBT6wFqzlofvImoPNvl34gwbTDeNPkibMHIVmZQhYXCXrubcbllqHjd1k8ip/mcyyBvluRl1w24ol9LczLWQhAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050472; c=relaxed/simple;
	bh=qrhbYvBNv/N0VI8PEYpw8zABc5tgbspPTRKzj2j/IcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiRu1LIuyL5dZ460HVE4EjCRvoVzMElrlBfLjOVctVyMgNfPmbyq2Va2jTFywV7NzSyXrzy7IaGG4RWpo9MJvX9YFOT5V7z/vC3nu0SzR2TXNxeTPYm9DTIX9epU+wzy5p8EcCHrTrMq3mJz3lWzamx371UtKyJCW2hEsPQpb4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP1Cwo5m; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP1Cwo5m"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33c30fcf33fso603733eec.1
        for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 00:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792050468; cv=none;
        d=google.com; s=arc-20260327;
        b=HwmLv0rHrwU5ONhCkQRW3rsuqlWC5DkbKWuK9Reis6O3aBd2M+n554NiYnrtDgr54e
         5oGOGv02T3b3MKFIBxGh2K9NtZpcoxB+F0HB0kpPGzQw59TKfzpQbD97mvVwpsLSJfzD
         fIJqFjJ5z74LWvnZLVajOrXm+NlAAH1q2oQY4co+2Ug0G27Ho5gzt8oZz2Er1CqsAOP9
         KyuRnuA1BgxLXHX3EgqWW7cWNtsVUFYoN0+ZWbs1ZXiyb6pvnyYWBTqAod2/BpA+sLog
         Cuf+4MNvxGQTMsh1Md7kKDyreua0iajX8a9EQpyx+g322VWQD0fhJl6LYQafqxyYI66a
         O4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aZLy1FDhAffyNHLdSNSc3Bq3qLESgLIT723DgtaMR+Q=;
        fh=DU/WKAF1F6V4XrwWQOCIk9OOl+Vls2VySXWKiETpFbg=;
        b=ipoMLiscm0aL4LLUhpCecvEYpJuVFg1xsJEVx85OIpYeWAZGx1hYbUvNZHSdicpwrE
         Oigwslpf6WQ16HQPGSQAIZxl1bnCoMYAbRoTxszvZqRanAoLlCYbSan5+nlTNin2M+sN
         lbd1WK6VTHuXL5lPcpYiK9wKzbq2l0MSQ97vBi5l5Az4caoncdT6J3K2Q5XgysI2DsHz
         Hribjd0Sq5B3G4Glr+8M1/vTBjaMvXr5B9IVkrT3Y4Pc0ILvJzJEDjeL/B0GoEAMR2x/
         3dE1CUxM+Pny7vew7i5NwZUBLpOLNvLa62bxnNY7IeNjwUhZbVmuNrI6sbxUHaVPsKd4
         HHAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792050468; x=1792655268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aZLy1FDhAffyNHLdSNSc3Bq3qLESgLIT723DgtaMR+Q=;
        b=DP1Cwo5m/G00Qr36FrXInztSqahs9iMMaMxcJ/hFcP/20kNJe1kQqR6npnz101hC7q
         rYCdDkfMUQtRBnrzHGBICeicqiUxrC4xZnALWEt9IPH4/3PwfLSPtGtbr3gr7gd3iFBp
         NyF1Cjs7VZki2xIGfCUzMqsaJHX+xtxdg/vlqTehw2ZLOBKx0g9Tq/sgxWija7I2UoJh
         5tzlBmM6Z5MGtPKDl5+PVZltvINZbU6t5noxgKfgjE/cF2Djt7Q/tru3JTmDBljIsY5R
         k9nmP3lcjHHYX3x5OEw/Rh16SPIOpTQEcHrJJRIzvp+H8XrlBpC7KG/Ny0+NgDcohfCI
         nmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050468; x=1792655268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aZLy1FDhAffyNHLdSNSc3Bq3qLESgLIT723DgtaMR+Q=;
        b=VRSqTAbKPEJ+Y+3ac6YJcaYNYhD7f1rzabht+TaVg2p0DHvOVgewaVPFBw8xxKc4Fn
         lFC4EZUsdfgzgTYuR+ISuXfiotJinkCfSsL4LJiqywQNo3LIWcMB2RkL1lHBP+Qf/6QQ
         w3bAT2HimadoiJ+XEuZOoL5Qu/oKcOZlPuHRLoXzB7IQWmxCmKF5GNdochuLzWmEc8ph
         2RqZkzFiTrZ0fKSMtwwzatuKi8lRF7pD0hwAsxs26moWF7EtRqNVtvDpXmNVz7/EYH9y
         kKBD4pKASIld7T0ZUmEUgFwfDn/beLXJ/yOc2G4gHwLlSFG6OUFvZlN9icRIoZcau+G/
         HRvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxsUyRkfPZYbNIhJFD35CR++Nx62inOoZazf20hitvbak9f6NgHuP9aXPKbktM5EHIDYfO/u+wouwCW0sDyqsQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhtutDq1CVB+2FV1DYOu5Kca5LHsLyU78ad6TLq1TAWO7+h4TB
	AIMjBNk+YrWIrcUy0NXXlUb/tSAnWWSY0TZoftjDULyM6gQQNwcNrf+2/pwQppDE5me2vPWqr8P
	69RlphLhXdwWvlPpcilV+H31/Y4Evin0=
X-Gm-Gg: AYBFou0Mz+ttwrBMpQKTTkH10k8j+mTWrnmDmD8kKjNjEt2JzTtpgcvx+5hx6zLZNSN
	ICNq9byvMdj0Hb1cyuWXvwPvmRdhvz6n4AokkyBNs1hBNV1Ep/GlbH5VwamaXIznziF2s7jXThm
	FjP/6L/CtAdMPWDbtnnUIDlVI1STOoQcEKk6BE4gct1SAvbK72d99okmdvYqey6OuOyxJS5+sqn
	jBRSzD9K0gQj6ugpXCxcW7s4JfL1kijtGmjp/tDdYeAAQG1sPL9l39WhKVZeWYH5wrP+sqdUwk/
	qjtni9GG+pZBA8R/y3M4KhFAJg9Cx8ecc7VbbttGG1xmTdYlC0Sh92zRX2nZroOLFk2cJLzo26w
	l6XkmemxS5/TGBbLirhpNlKtUG+445UyO650iEufj7rb/5MaDJvvDG0WNryXxBTuBM/X5YGiVdO
	+pxxQabYYdjNssWs6mKtftMuNw6DoKA8yxHblKaYyLps6/QVHmOmU=
X-Received: by 2002:a05:7300:f3c8:b0:351:7883:bf47 with SMTP id
 5a478bee46e88-3537dc8e9c0mr38650196eec.0.1792050467352; Thu, 15 Oct 2026
 00:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014225811.i.852-kees@kernel.org> <20261014225818.3457479-2-kees@kernel.org>
 <2026101517-profane-opponent-4523@gregkh> <CANiq72m_iyquf4Lc8AWvbsBp++ASz4+C_MQ5iYQW-fHd_MNDxA@mail.gmail.com>
 <C46E97AC-3722-4264-B541-04EBC3091E00@kernel.org> <2026101532-fantastic-deafness-e04c@gregkh>
In-Reply-To: <2026101532-fantastic-deafness-e04c@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Oct 2026 09:47:34 +0200
X-Gm-Features: AclHuK8JUch3-LLJNkG2OM0JVExMlV2wP7uKNynE1Z6fAhzs1hBzwjLh_wcCofk
Message-ID: <CANiq72=wS5NJyeKKaYiHKWhDq2Wjk728qkCUNq4xVoHrPEPCRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] seq_file: Require explicit initialization of struct seq_operations
To: Greg KH <greg@kroah.com>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-fsdevel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 9:11=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> __must_init might be smaller?

That sounds fine too. I like that it says that something *has* to be
done (like the original name did). Hmm... On the other hand, I guess
"must" could sound like one has to initialize the field "somehow",
i.e. writing:

  struct S s =3D {};

definitely initializes it, yet the compiler would warn. Would
"explicit" hint a bit more at the fact that one has to actually
"write" the field, even if it may have been initialized anyway?

(Of course, if one knows that the attribute only applies to fields,
then it doesn't make much of a difference)

Cheers,
Miguel

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792757413;
	b=yx+ww9MqVQVCRT9OVK3BIMCurJjCTzc+XybxNQaRaYaYArJ/8sM92ukPFBlUa4rOfIBd
	 kloZg9LSnQKoPULEkEvioTYl29M0wsWymnIsQ7ngU4I+BZUJcG4n4j4NIgXDyJs1ZydV0
	 HO34UIyml6sBB2FSwDlGPHWzQ4wpVgCEZtXmRa6d6V5h/r7OReZ3R+TKnGD1BOY19KOD3
	 pJQnptjmr4CiAWu30JZ5ntQpM0ZQNgsrRUzCalE8lI5pM1ntNf3cLq0RAGOk5qhUorSbv
	 KWKpEsQywi5uu0MHNGtirtpSF3HJr6He925apovUnEDbpuLNg0r8lny1Y3tMEWSij/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vmXE7xFhodQ9qb16dVHHJRrxUXaSprJpJwS89829b+M=;
	b=hPXCpfh9t9BoF3liUz7xitNCzZkXiMh5p8mvxf30dHnlyqRUeJXYFNSbxahPE/jEQf8Q
	 VceTmFXXOL3+gfQVSaCCVrGP4QPNzv20EyOfgmnSf61VC6rY3gy8Vn6f32PjdCHwAs2Sf
	 eDRkzPccuNPqJVE5ouuABM8bTCwixgouECCZqSIU+FhjsHCheHSBjyHdhG6J6AO97+I3M
	 tkFAChE7HKZOEhOvLV1SByLfaF05u6APHM0w5eykV4PnVOnkLk1Wio/mKgk2aX4Lsu7l0
	 ZlORtxBFmquUgArt9aLFlDgxZlg3RkBmWFe3uoKHL0YkJl0OzvuJ3lEXmRk29hEjxyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RNXrxh5f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16FE606A31D
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 12:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B16FE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RNXrxh5f
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so328045a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 05:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792757412; cv=none;
        d=google.com; s=arc-20260327;
        b=VE2bT+8ENU9itkhm3OUb3qcrJfAXf93nZ5Sj9JUX0l/lQwHDTf88Uu+zH5afmcvsP8
         4QBLO0xBcHfPmsI+K5ZfoPoCdmPP5+OfbjVqx2QI9UQKNibXXiO5Xv/ynyBC9zkI5NuA
         YBG8feeGAQTmWbmEq5dpbPbjqAnOJGIHW5Y0xo4u8tii6qxqIdyLYMahIH8Te6dWkfPC
         xmKaGrhscwzn2lf41jxO6eiPl7ENzaQSyELZYV2tnDnaa48iD19M0qeoR7OXsPAFHmz0
         M3Cf+OBlbVBWnx+aGM1gjyk0cZKo/GpNVSPG9DcB9laRbjzU0mSvko+orM420BxrDhPD
         u1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vmXE7xFhodQ9qb16dVHHJRrxUXaSprJpJwS89829b+M=;
        fh=JoPJ6Xw7iaNr0hBqMSZDCfwUbJZ9rLtT7w+vYwzh3is=;
        b=XxeTpObEqa9gxlogM+pzdsWaR7dnm+ljws3yKajMG0tIhcsPDfHxuh9Cz+3JxNdPB+
         G6spig5K+5TEAYd/VZyT6HoVt0KiwWzFYucCuj8TPtOMNFSXdWDA1CWh8ex9kRI2ceHN
         NIHfF1AMTyuy1y6+yWdR20mOfrr8HI6iATRPWOBWjc3K6J+WPiY1KD3urb5W10NQqp54
         g2RZvYiEsUFTD+54yBDGoDK+APGCjG1kUlrmNDXwYtVTCk59ay+doOKNsnTEC2XirVKR
         cdlHJwpg5yfTsTs5ei9+HfrvG61H9FfBZZPS4kltNCfjliH1ZLM9XPnfInxcS/ySIDq5
         9iHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792757412; x=1793362212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vmXE7xFhodQ9qb16dVHHJRrxUXaSprJpJwS89829b+M=;
        b=RNXrxh5fu4Z+fIUu8LXjTt5UTPvq+85WkYn2PxC/ShshdSZxVXfJoejQkvDRcTHKyy
         QI+l4F5CVXyIKFQHLs/JhmpUEO0wKkcFcLJmY6KUaQYBOshPXtQ5OC1bleRIcIn5oNm0
         J24lwY/Yuw828XRePT8HyclnU4x8K2kxTG1kliQBqGpqglq91edPy11Ze49R3XECAwAH
         SNVPjflCNhwit+b7sPuFPZ3BRu6uzZPkPtIRC2NWA8/PkFnv/btYVPDdUGCnnDkiIk2Z
         DpaWNG2Rb1w6CTo3g9ltS3QwBXiIQnICKueq8zhBc6NgD2ud0/NP22cWS1VU46Cju3a2
         xkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792757412; x=1793362212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vmXE7xFhodQ9qb16dVHHJRrxUXaSprJpJwS89829b+M=;
        b=UfIeeF+BRhmpVXXSFd4CbdfFvkoO85++3PYPqYqgNbKMrz+MIey2zg8H79a1Y3UGmz
         mCK2YliJ4tzEowAZVAMQfpqf79wFZ7qB/zMjlOZvAjRAxIMN5H2vCaJPyWP3sAhYSwqW
         AkAneV1pnlf07uHueJNnEWmtFrvE/qaG7zRUo6WcuEDuq6wHe4801M+/dV0AUeOrHawd
         i3Vd18Jpc9HT7cBYoul11N7AE06k6GcXnPKXNz21ww3pAleJu2xdRpNQmCGQuo1mUcny
         Rw0EOeisQhKytdYIx2Cns29D6p/WHxIESq/RTH0xOHa0XnuhgJMs1J7fLZjI93QB3Quo
         cgFw==
X-Forwarded-Encrypted: i=1; AKwUvBxPWAiqQFdl5WFSwBJcZfh2MKnYPWAbwKfsd3/KQBf4/0QXq4xQW5d5kf3mdTPnre9Rnv8U3PYkx2RmyexofUc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1ZL33SuOHAm78E8XuoWN6JCe4YzOZGQ3nMxKzX/7C9yngfnXc
	sCuLJVEZsrMFtZo0OliRBDI1E9P3PnUHIDSJTjSh4PpabWWVqgtXEinUyYAtdmxPO90v7kxI+MP
	LjXcblrlplNhSZno0ZHp0C15Sy9m9y4M=
X-Gm-Gg: AYBFou1ZHRVAfGw0Aiz0zuillxxQvU1MXPjZq7ALqOckNxFKFiCQylj6prYakcKAyoy
	46KpZTNn5gI2DJIQwLR/XhzcgPBKNeSgr9v/Q3vxisCW/HhHyFCbqmap5F6hPcGtO+198lhxZaw
	J20ThtxHKsTr5ngNXHw3E2Y4unvfIMQ3tyPha+xJKbdxCvHE5DjvirT4tr0GFQbLS7d1CH13d/w
	V7Rqw8M4gtMlUB6IVkVSjM32Yww5quhP+bwSFU2IA8MjfNcC6/awWJ1eoN8MGBi41kWCcE9iO3K
	USqjDCXzDLeqWlYNev2lWzLb6C7eGTy3AbjgJxvxS2DIku8EaMu4UC9UeyaBXlDZRfSexkUmg52
	pJeMmEelE8FZ1zUm/VIK49eCSrgQbHFA=
X-Received: by 2002:a17:90b:2645:b0:396:41d1:cbc7 with SMTP id
 98e67ed59e1d1-3adcdc94d2fmr1844935a91.3.1792757412088; Fri, 23 Oct 2026
 05:10:12 -0700 (PDT)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015194513.i.609-kees@kernel.org> <pr158sq2-203s-20n3-q44q-o599q271r309@fhfr.qr>
 <ri68q3sl7zi.fsf@virgil.suse.cz> <202610221224.60CF7CE4B@keescook>
In-Reply-To: <202610221224.60CF7CE4B@keescook>
From: Richard Biener <richard.guenther@gmail.com>
Date: Fri, 23 Oct 2026 14:10:00 +0200
X-Gm-Features: AclHuK9LkaPeQNRGMB0h3M47pxHRje819FzgF7bb1NeRKBI8CbMxvFfTPHw7iyI
Message-ID: <CAFiYyc14ns+-c5_aJ3WDq5NLTcQAZWDzJ5mV_VdA8TudS7J0EA@mail.gmail.com>
Subject: Re: [PATCH] ipa-icf: Step to the next caller past a thunk in redirect_all_callers
To: Kees Cook <kees@kernel.org>
Cc: Martin Jambor <mjambor@suse.cz>, Jan Hubicka <hubicka@ucw.cz>, gcc-patches@gcc.gnu.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 9:25=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Oct 20, 2026 at 05:14:25PM +0200, Martin Jambor wrote:
> > Hi,
> >
> > On Mon, Oct 19 2026, Richard Biener wrote:
> > > On Thu, 15 Oct 2026, Kees Cook wrote:
> > >
> > >> redirect_all_callers walks the callers of N, but steps past a thunk
> > >> caller with next_callee, the next call the thunk makes.  A thunk mak=
es
> > >> only that one call, so the walk ends there, and so the callers after
> > >> the thunk in the list would not be redirected.  This came with the t=
hunk
> > >> check in commit 17d1bf760f8 ("re PR target/65263").
> > >
> > > Huh.  This looks obvious to me, thus OK unless Jan or Martin object
> > > soon.
> >
> > This is fairly obviously OK.
> >
> > Thanks for catching this!
>
> I don't have commit access, so if someone can do that bit for me, I'd
> appreciate it. :)

Done.

Richard.

> Thanks!
>
> --
> Kees Cook

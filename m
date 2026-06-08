Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06443988E1
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905403; cv=pass; b=u+pqOr4jxwUwSKDmqN+wBZVWaVNxhdZIV6rKLThchtjX2Hey4/NkFalFTvBCFzF4lCVkLzYSMtbHr3gP6BA/NDDAWECHjRHHRsaQr5W8zwcMUJW/815VFX3kn/I3aY5dECMlf6f5yMXl8uz9+Sp+lY3pCV3kU8cGa8SFajY3uTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905403; c=relaxed/simple;
	bh=v7MhUyKLpco5Pty2ROnWb6vWgtSRv98FtHcFuzCTDt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KY0qz6r3PiJBqoiR1khM9jMcmlxivJI9J8ELsCfqqYPuOCV6moo+7EJan5Hm6+2xurcB/0moLMNMVbU0wKlx5tKJG5VzEENSjJOXcYxoB2LmZaTNk6Dy5lvpY+GP6ZIe25Or56tx4SUfCP7zc34TSgbvkYyZWZHmmfaEhuyJlvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SibH7Gmz; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SibH7Gmz"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68ca6f01079so4579955a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 00:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780905401; cv=none;
        d=google.com; s=arc-20240605;
        b=k5FpHjlh5sm12FhIUWbdNs1aAjPPYBF2Ezne6f5wJYkkeRnAPy5FFZcrF96DoDGn+N
         zpOH33vxpMxhDNVcv2hjF4wiYNKt07ypJAmDZf/ZhURRJURpmwxJbTr8Phpp0lmy8s0W
         T7QUjvKYQBjjtT/YZU+W6ksqqaS0Fww2thpMKiFfRBN22y4F6awCJoTKlpL+WUQhMncK
         B4WVtz7KR03oZtiX2OklirsJQ1Hm+6GAfwAid7ihQ8h/2CsyumDN51qlRKY4oUZH2hQP
         yH+DqihnTMZUT87UUgFuPUobH8eQVQSt7kS6++GqIHhanIG3SsNWbxMoSJRriMmSMGuU
         C1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=v7MhUyKLpco5Pty2ROnWb6vWgtSRv98FtHcFuzCTDt0=;
        fh=tnkM1ruYzvzurSyKILr3g0fyZ+U3tAmLPcCkDEH08vs=;
        b=VXpVopPdNAdyo0F0gQNv9cy5hNb4MlstJsKG0pVFJiub4UCAj5yNxS3Tb+NbO6jYAo
         jdHcQqe4L5U/naE3dNeejKGBTymZy3ZdCGJMU5l3ZIlGb9IrgAetrd27zkefL3v2jKK6
         0eCv5EVgk4N0BhE/hlEDXOiE4D+don3/BccDzTiJsWIMhChUfgjSCg/vauSiG7hR3utF
         GH3I8lkRnZWGkwDr/VbxqYb+bj8sWMG07U1v5/hgO2qTXmiri5M3V4g0NEU5rA9dqKJE
         WRTIhDO/EaQ9xeVmjUCYoTWN5nPxoJRAZfeOZOZKoYDvwtIVT+vevW/UBYVJDEfxvTUl
         Z8fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780905401; x=1781510201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v7MhUyKLpco5Pty2ROnWb6vWgtSRv98FtHcFuzCTDt0=;
        b=SibH7GmzNgkR6oeMTY/ftMT89eYk5qojSEXtv7wBe8+YVD7wVrj1mwK3NNyQzT3RRE
         PtrKqhDaOq1x/3GkjxYJwl3VZ4HP0f2zcOiEJMUfNChjt8BFO4Orn4DNnYqm9ur+jOJK
         m62Q9kk/I3XPiZ0OFdWD2Yq+HJX7od2Qe4ioPMXDFl1x+/2Vca7UtKr5m05wa7g0An9o
         vnA7IVQvojkIAAT9/wRWvsXsp7PZC89lEDMT0xKmhr+9a4nvsqAPBRCerQQCYccrPwiS
         lCAW/uHFCHhPCVU3cCSxRqjMqkL90nWLCfWin1YmQLdh7iyPgxwr96y2+Rg/EVvEJ5Xd
         UhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780905401; x=1781510201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7MhUyKLpco5Pty2ROnWb6vWgtSRv98FtHcFuzCTDt0=;
        b=Hxj2a48Sn/r9QHanTgwCKRwfFM8o9sPzXVhkG0qFM3Q1kHQ0cRl8kRWKx5/Hp/NcCX
         r2YzV4P3GnI32aBNoPKtdxkvLKWmCDek/ivyXaCi2NmddIp5O+i7R0vAZFbG3d6vbPtj
         z+UqFKpSy96bQg07+VAM57ZsqksniXPJsZhtfx7BC/Ty6t1tn1PEfkQYA8ui2bfU8JNi
         EliFxPKFJjr2eHR2gIXGLDlVouUcg8TGhhEzB8ImIZZ5f0SI+5Br0YUa+NZ+ANsjsyER
         +VZx06HI5mzMzB7L51j7d7iA44EfFiFbLy3iJRxlu19+Fo0QJ9/L8JnByHB9hCfrKWM5
         IiKw==
X-Forwarded-Encrypted: i=1; AFNElJ9KUejK0DBgiQeme/UeAn3A/zimZDd9PY90xmlPWF2FTiFsuWA4Hlm0s99QvAnlnPggzuR8Z0LJ7Og8l6y7V/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxpIoo96EPvKNIJPqSqVRvxWN8zmXZKtGOCaKdyLyscKZ59qg
	3bOPUOvIhCfsQzP9RUP5ZfDTI/cAYzdlNJyvXUD5dV6FFJO2yKFpmD2pt2ALpJHjJp+vBcQSI0E
	wP8dP1RA+07OSz07C/RX2yQ6YaSQF6Q==
X-Gm-Gg: Acq92OFk0x1KxdOF+JZIAL2fBnj2lciHNKmBSXtjI3jCF3KJJlE2HGsSbVlYHFGjUDm
	9jDrjpDtDPDfLQnQlleZx7F+4hE6EME2/KSilUKvSSggUutZb2dQdfoWhUNxJo8vpEalleYpofK
	qAxqkGaktl4UIGa74rLmjSrRxHGPQipBxqMJlPhp+jw/LVMODSryD/e8U3M6TJM52g8Sw264Oay
	+hNt6gZoYc+fS1aKArvi/Fe9e6IvThdrJ/odizGfgrrjr2pb0uuDVpDLk6zCVZh8vHJvTbS6OLo
	Wl6pk6TH/SVCwNknCn1CRInmzbGUPnVxJCiW2SnEScPos1xSDEtkqsByf4kWwn+OSIEZSqEqBSO
	HaVDKweOVl+3lXF+uEQ==
X-Received: by 2002:a17:907:96a1:b0:bd5:ca8:768c with SMTP id
 a640c23a62f3a-bf37234aa66mr653540266b.31.1780905400661; Mon, 08 Jun 2026
 00:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606155856.15548-1-med08elkadiri@gmail.com>
 <20260607070645.9559-1-med08elkadiri@gmail.com> <7906bad7-4e64-40c0-a724-f55ac44e12ab@kernel.org>
In-Reply-To: <7906bad7-4e64-40c0-a724-f55ac44e12ab@kernel.org>
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Date: Mon, 8 Jun 2026 08:56:29 +0100
X-Gm-Features: AVVi8CcGNyoLbmamtMoNx2-0ZzTmIKgNBdQkv4HaB4rzJNFkS3LOZowcqOrQKLA
Message-ID: <CAAMeuQQFgyS1KR9tG_fW3yXhftmt1Oo7wALnc4WhnNuRG0x40A@mail.gmail.com>
Subject: Re: [PATCH v2] docs/mm/slab: document cache isolation with SLAB_NO_MERGE
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Kees Cook <kees@kernel.org>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vlastimil, Vishal,

Thank you both for the honest feedback.

Vlastimil, understood, I will drop this patch. I can send a small
patch adding a comment above the SLAB_NO_MERGE define if that would
be useful. Otherwise I will focus on code contributions going
forward, written and reviewed manually. Appreciate the guidance.

I will follow Vishal's feedback and send new iterations as separate
threads going forward.

Thanks,
Mohammed

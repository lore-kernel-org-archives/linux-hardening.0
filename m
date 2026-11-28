Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795851452;
	b=NesAOK6zUl9ghaKYfhHpm9pQQuY54HMWLZjbhKNq0Qo+elJLE88PI4kyDLUYWeVVMSyO
	 qpCZJmxh+GAiIqYI+GAhjdJSEhdC+ubYzSrcgMlpgUPYcORJ7462uryVwu9nrHyUL2hhF
	 2r+nqfv+4yv6JOaqb7SijHyEqASNmNlrIs07NgpMZm5WuBf1qb51Y6P5JHWEgTBrvfHSC
	 j/367vgPmN8MJf/U3rc/gzyzd73sq6AlUbU72efyhkF50GuflI1g2dxVKPrRkfp2tjTt6
	 mwmiKgQu7MheXcQXbTYW5PlOk5pDH1/VF8ecNC5RSRBXCgy+X8AAOY8BGpN1pjDX5gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795851452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lL+jKdd4J7vQfapOu6Q28lbNCK5lQEUpkixYLsmn0KY=;
	b=aiXoJjfdGSZDZYTxuCOXtnZUS/HucQd2rylMZTr1FbSX+3jKomjfeLRZv2mcjATy0+Wb
	 xY6owXMIDqcHs1JomsKRG4fCOX8a1Lxeb5vZBZtj0rn2OKxf88TFGyi0Un8BeOBzZfAkE
	 qDgO4Tzu3TvWoazElTX2D9lEA1ZTwnqc5QM+Sc4jrxxIvsLTPNnro8okp9UmTpA614qXj
	 QWSSnIVMc+FJCPdwaTwo2p2WkuWnV4Dz2gV6JMdRgaUQiGWk3abuJsLmFOJFsilZZGSSd
	 IMrqBWsr6QnXzp6HLtUDXIqQR4eF6M6B0ecy+UQ/8LJOxSIdCnsk9oP9BuoZRod4Gyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DRwLAdTx;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB23606A31C
	for <linux-hardening@vger.kernel.org>; Sat, 28 Nov 2026 07:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BB23606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DRwLAdTx
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a3c08d6928so13121018c88.0
        for <linux-hardening@vger.kernel.org>; Fri, 27 Nov 2026 23:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795851451; x=1796456251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lL+jKdd4J7vQfapOu6Q28lbNCK5lQEUpkixYLsmn0KY=;
        b=DRwLAdTxfhtXOEYCPHlkAS1WoK8xeQ3sQujKeRacoK9fs+WswCSFeZfJ8bwpyoLznS
         EUXp6gUKqLD8pNaSs3oKxOljZoL/z5nDk0WC0ImZUIqS66U+4hTocOROd4MZ2ovV+EbV
         pInyiNuDvtfkdIReVldBO4znzQdsFWHtum4Hiv4wV5RfyCj0++m5LAc7Hxz3o5qYeltE
         PEVH59haCyuCSSANH7ifnqnxvQgkhIGrYqEjWaBvyT28c6FwGFtxqKe1Dld+UIU/earP
         UxODcillAskJWpSIbGHTGHn0jjxhhc/gtXOtRmeQOi8B0HxfMfKctzCGXlGH+gMiR+dJ
         8btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795851451; x=1796456251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lL+jKdd4J7vQfapOu6Q28lbNCK5lQEUpkixYLsmn0KY=;
        b=SLelUsDgAHGlTCmtTelcKVyQnxkI0ePH/V/Yab9IQihiPLdy1z81qlMp8NiEjONlvW
         GPixo2mnGB7i5cDCM9PCkyd8yl2Fl5QwYh6dljDJajQFERfktopuEejpyb7blqSfDZx0
         nIbdvWW75LdwTnOCquESDKiihDDg4S/QUTm8CowHEt5ORdeGwrcIfag9xonmjWWK0nxi
         p+X7wj2To9jtbh6jNd2TWDZBGo1hpwhoEpBtBlGT/0rmDqiIxRq+Ajud6cILIN+zaeRN
         CUCVvFVyIaQTcTr/9H1GRxrr1VmpX8UFHh4MslXoq+tSsVgY6z1LQuXz54M4uLIunX6U
         fNgA==
X-Forwarded-Encrypted: i=1; AL+hErEHX9vkvjIsqVKhyRl6vEqg+ioYgZlvBLrQQFfl8hDgw220j6CuJvFNU35ak7yUPCNo/56dn4TtloArreVpodU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RbAlDA3JPazS4xvCiyGPlyfrj+BM4SMOfA+RBXzswhYEBReNF
	bb+uy8ByfNX01OB1RAZ1PzX6rWhwnNo/5Am8YqrEKLJoI86w1wEYDCfp
X-Gm-Gg: AZFdTZcr9gZpQZ0WgUxhxxCuMJX0h2mP3CYQexBImdruntlcSeFZzba6mtZDqT3UUn7
	RgnJO8VHskJyWwuFZQh5evN9IRbDIAPk8m2UzCpGFUTsZjXz7jlNOFjuRk1nmb5kQm0R9DYkP15
	SCJchmjt+0FtUodELoriMjowu0vfQKuKvgks8wMjXFdOwovJ5rbsHy5wdFmKeI/BIlgAYTNsltN
	MT6ZR3TT9YONjpBXHnNm14ObiJEGblhSCPbf1qOKQzIdAKdNmEovrAI0CtyorPhwib50pweWAA1
	y+rWMBBupa/X9jNO4SxQSC+H0ofwKvTumMvtuGL2VRzl7FS3+3ysJU1Wy+f8D3JAhlOqs2/UNMW
	c5KzglDSVntr5ec66H+vVZlyPt6D6oBilxYdZ4517wMNqOqsYy1qLLtTQFLeIIbbtgq8pCzpiP6
	m94GGBMKztuOLE3ztRNEWtwaBwiBYFmEvwBCbspza1EKUIi5tOIU2w5ZnsjZF6/fMgPcYjMlnwx
	Y8qIOjjFdZvXdhOTXUw36ge5b3bHL3eV3bic1TEXEFXI3LX1ffSszo+Ad1VxwBpjprsJR3D3zXL
	1apzZDPpNiiwijXzWUNQ1CnIbFYaDDws2tudkE1JJl+gV2iv8iSIwn/I7E2qwarG9iL1
X-Received: by 2002:a05:7022:23aa:b0:1b5:23e7:3387 with SMTP id a92af1059eb24-1b55688dd29mr36586570c88.19.1795851451449;
        Fri, 27 Nov 2026 23:37:31 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm58146062c88.0.2026.11.27.23.37.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 23:37:31 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 04/19] mm/swap: introduce swap device iteration helper
Date: Sat, 28 Nov 2026 15:36:45 +0800
Message-ID: <20261128073709.33602-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CACePvbU2cg1EVBjONWjYcsanDM0JS4eLXgX9aGYeEaXu4zZ2-w@mail.gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com> <be6ef058f4a6babd3562270daa5b61c4ff9a6a50.1795439990.git.lianux.mm@gmail.com> <CACePvbU2cg1EVBjONWjYcsanDM0JS4eLXgX9aGYeEaXu4zZ2-w@mail.gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Nov 2026 09:26:29 -0800 Chris Li <chrisl@kernel.org> wrote:

> Nitpick: Suggest have a internal version of "int _i", then sync to
> "int *i" at function exit.

Thanks for the ack. The macro passes its own local index, but I agree
a local int in __swap_iter() makes it clear that the bounds check and
the lookup use the same value. I'll write back the next index on exit.
I'd keep it an int for now; this iterator has no other state to carry.

> You don't need this WARN ON. When i < nr_swapfile, the swap_info[i]
> array can never the NULL. If you are paranoid you can continue if "si"
> is NULL.

Agreed. The pointer is published before nr_swapfiles is incremented,
and the descriptor is kept for reuse. I'll drop the warning and use
the _dev names you suggested, with a comment that the unfiltered form
also visits unused descriptors.

> I think for_each_swap_info() requested flags as SWP_USED |
> SWP_WRITEOK. Is this intent here to catch the race that SWP_WRITEOK
> get dropped after the for_each_swap_info()?

No. It's for_each_avail_swap() that passes SWP_USED | SWP_WRITEOK.
for_each_swap_info() passes zero, so the flag check in __swap_iter()
short-circuits without reading si->flags. In si_swapinfo() the
READ_ONCE() in the loop body is the only flags load. It counts usage
on a device that is still marked used but is no longer writable; it
doesn't depend on observing a change between two reads.

Thanks,
Lian

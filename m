Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961CE1DFE21;
	Fri, 22 Nov 2024 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309913; cv=none; b=Boa4PKgPR60+RdQosrOV4X8wNdPByJHE+An2VUVmYQ2JFFCdacm3CJvfeCu6EiRuZgyzOlDlEcU6xjUBUvfzS16uZLzEayusEllNLVe1OFYKq6FtOyiEZyGwdM6p5J6VSZNgOsWin13YWWulAmMHSz1LeS14GRzINMhQG+7TMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309913; c=relaxed/simple;
	bh=U/ZT9qf7ZKkCSNGX+LQdpSzD1zHrMzhIdXfNFvInpZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mvqc0oDR8FF2n8Q9Aycv2W1G+XSAsL3AGRmAVh3N7MStI9BMjW1w4RWZHctvUFq/JEmSJD0d2cbYf8FwdVOH51HVYa8K3/qddGpFMZepUkEZeqOxqpgE0EttrdCHOkJwikTFXWc4kO6CB58n8LxRY8v9Rr6LfNaC33kbD2++PEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5BD0fz0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5BD0fz0"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38246333e12so2355079f8f.1;
        Fri, 22 Nov 2024 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732309910; x=1732914710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcgVp28W6926MpWbVahmMBx6XNYuxWBUeQ7ocOEgbMk=;
        b=M5BD0fz0OooUux1s50QO5dblP5yZLeNX9a5+zrYWotyDvpKKNiQlniQdYbg2Ozg8Uv
         l/YbcMUs/Mwu66hYHG42KNhXLYHJbFc5iBHaEiMl+7KeJyn3KHtrbWEWM8TntPw2dscX
         SlUxntLNBPO5Le1bZyfeyLRzlJDo4UOx0VLDgU0ctZRVVo1lWKIZ4EkokijXJvDJen6G
         /F6yzJc63WEtUB8oCOV1RZszYQ5NQj2iIu6jwv9i6/N/HZMv9Hq0IEUzF8WcD0bzxZtp
         n+qsQr9QuNeOPEhOW+8BaabYKGZbACW3Ee/nHQEF14nVJmqRwTkfxIRR5kRlIF4aC0rF
         kz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732309910; x=1732914710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcgVp28W6926MpWbVahmMBx6XNYuxWBUeQ7ocOEgbMk=;
        b=eLcpRcsjLJa5SrRhL4fvPRXQ5DApJDXMnXVkbGv8NxKTSlyFukCweJ9qP4E/XqBnaa
         5afUA+9B5r1Q2pJZDe/riY/O4y2ME75YPxUtZ3bagu+TB+Sr1eAC8KoGY9ptTTGi53L+
         cDZ164tXt4yW7seILPy3TRFeWJNxCkmn+01xGa+66T8lnlKPC0okfNzpkXqP8GUSDg2Z
         CaidehSCWyOxuSRE1XMZQROrgBzVaZkJ1yFn1TXaAbEsQvfJnW0qRv4AvPfN/qDW1p5s
         JlUb+QG6H1X9MnOCrHkLTkjIz7GoV/5DbOReutWxw8qUNfODaRY3qAOduKe9BdeBUkqz
         TT3A==
X-Forwarded-Encrypted: i=1; AJvYcCUlTiS1K4v85oMGN/co7vxizdYITAPZNI05w9k+IRw/9SbOL4k0ncXrPnWwzQ4mGwHt+u3RIu/Cfjx2wB1Ric0=@vger.kernel.org, AJvYcCW7VBDmOPcfZ8gnIBKdYLf05vUtgkPyoTKR/pMXbKhrPz4QC2uv6g3ArxA6cetLqugzZ3aWpbm51IDOuESC@vger.kernel.org
X-Gm-Message-State: AOJu0YwlB7kgkX8R+/aNWLK+6sStHcTpTWN1E8OoW4kG/NwOvX/PMVP1
	QEhGSaT7GX2DwrWSY6v64gWlohsbUM2gFPW34Ba3G2EfPiOQP+I0
X-Gm-Gg: ASbGnculE5vU38KuzawcK4Yk2KkcXqz8Oye80FfU35aE/neagqRuXWdxA2FwNofVOZG
	jM0afBjKgUhGnXnUqZ0rFrx7+p0YKc2j1ulFTuK4w2EJtEXok1PCu/T86GPXtGg5AIYOD183r9A
	ZsKURJljI4Q6Dtw742HUvmEbUODFQ6sludRIdHGqxpGL0810IR1XINraq5qNhibpjuYPc61w8QW
	D0LDNRippKGh7LMVw6RjIqs3dDj6P3hPAb/lM13AUE8HOobqAaSC2nf5twnAYSSo5he13ltLhiI
	VRw=
X-Google-Smtp-Source: AGHT+IFSu94fAGe0a26RY9E0p3Dseadw4xr5xEPXQPPDLtYTllmCUrzyLNvFLTVBdweL0rlSUDFHig==
X-Received: by 2002:a05:6000:154a:b0:382:3959:f429 with SMTP id ffacd0b85a97d-38260b3cebemr5197983f8f.5.1732309909675;
        Fri, 22 Nov 2024 13:11:49 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3a3d77sm1276636a12.7.2024.11.22.13.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 13:11:49 -0800 (PST)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v3 0/3] dmapool: Mitigate dev-controllable mem. corruption
Date: Fri, 22 Nov 2024 22:11:44 +0100
Message-Id: <20241122211144.4186080-4-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122211144.4186080-1-bjohannesmeyer@gmail.com>
References: <20241122211144.4186080-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We discovered a security-related issue in the DMA pool allocator.

V1 of our RFC was submitted to the Linux kernel security team. They
recommended submitting it to the relevant subsystem maintainers and the
hardening mailing list instead, as they did not consider this an explicit
security issue. Their rationale was that Linux implicitly assumes hardware
can be trusted.

**Threat Model**: While Linux drivers typically trust their hardware, there
may be specific drivers that do not operate under this assumption. Hence,
this threat model assumes a malicious peripheral device capable of
corrupting DMA data to exploit the kernel. In this scenario, the device
manipulates kernel-initialized data (similar to the attack described in the
Thunderclap paper [0]) to achieve arbitrary kernel memory corruption. 

**DMA pool background**. A DMA pool aims to reduce the overhead of DMA
allocations by creating a large DMA buffer --- the "pool" --- from which
smaller buffers are allocated as needed. Fundamentally, a DMA pool
functions like a heap: it is a structure composed of linked memory
"blocks", which, in this context, are DMA buffers. When a driver employs a
DMA pool, it grants the device access not only to these blocks but also to
the pointers linking them.

**Vulnerability**. Similar to traditional heap corruption vulnerabilities
--- where a malicious program corrupts heap metadata to e.g., hijack
control flow --- a malicious device may corrupt DMA pool metadata. This
corruption can trivially lead to arbitrary kernel memory corruption from
any driver that uses it. Indeed, because the DMA pool API is extensively
used, this vulnerability is not confined to a single instance. In fact,
every usage of the DMA pool API is potentially vulnerable. An exploit
proceeds with the following steps:

1. The DMA `pool` initializes its list of blocks, then points to the first
block.
2. The malicious device overwrites the first 8 bytes of the first block ---
which contain its `next_block` pointer --- to an arbitrary kernel address,
`kernel_addr`.
3. The driver makes its first call to `dma_pool_alloc()`, after which, the
pool should point to the second block. However, it instead points to
`kernel_addr`.
4. The driver again calls `dma_pool_alloc()`, which incorrectly returns
`kernel_addr`. Therefore, anytime the driver writes to this "block", it may
corrupt sensitive kernel data.

I have a PDF document that illustrates how these steps work. Please let me
know if you would like me to share it with you.

**Proposed mitigation**. To mitigate the corruption of DMA pool metadata
(i.e., the pointers linking the blocks), the metadata should be moved into
non-DMA memory, ensuring it cannot be altered by a device. I have included
a patch series that implements this change. I have tested the patches with
the `DMAPOOL_TEST` test and my own basic unit tests that ensure the DMA
pool allocator is not vulnerable.

**Performance**. I evaluated the patch set's performance by running the
`DMAPOOL_TEST` test with/without the patches applied. Here is its output
*without* the patches applied:
```
dmapool test: size:16   align:16   blocks:8192 time:11860
dmapool test: size:64   align:64   blocks:8192 time:11951
dmapool test: size:256  align:256  blocks:8192 time:12287
dmapool test: size:1024 align:1024 blocks:2048 time:3134
dmapool test: size:4096 align:4096 blocks:1024 time:1686
dmapool test: size:68   align:32   blocks:8192 time:12050
```

And here is its output *with* the patches applied:
```
dmapool test: size:16   align:16   blocks:8192 time:37954
dmapool test: size:64   align:64   blocks:8192 time:40036
dmapool test: size:256  align:256  blocks:8192 time:41942
dmapool test: size:1024 align:1024 blocks:2048 time:10964
dmapool test: size:4096 align:4096 blocks:1024 time:6101
dmapool test: size:68   align:32   blocks:8192 time:41307
```

The patch set results in a 2.2x--2.6x runtime overhead, as demonstrated in
the performance results. AFAICT, most of this overhead originates from the
change in dma_pool_free()'s vaddr-to-block translation. Previously, the
translation was a simple typecast, but with the patches applied, it now
requires a lookup in an xarray. As Keith noted [1], achieving baseline
performance would likely require changing the API.

**Changes**
- V2 -> V3: (i) Use an xarray for vaddr-to-block translations, which
  improves the
performance of free operations. (ii) Remove the minimum DMA block size
constraint, as it is no longer necessary.
- V1 -> V2: Submit to public mailing lists.

Thanks,

Brian Johannesmeyer

[0] Link: https://www.csl.sri.com/~neumann/ndss-iommu.pdf
[1] Link:
https://patchwork.kernel.org/project/linux-mm/cover/20241119205529.3871048-1-bjohannesmeyer@gmail.com/#26130533

Brian Johannesmeyer (3):
  dmapool: Move pool metadata into non-DMA memory
  dmapool: Use pool_find_block() in pool_block_err()
  Use xarray for efficient vaddr-to-block translation

 mm/dmapool.c | 92 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 35 deletions(-)

-- 
2.34.1


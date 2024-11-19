Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830CE149C7A;
	Tue, 19 Nov 2024 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049735; cv=none; b=jS59Xsv14YVQeOwtSHA86vWFuf+sPUhT7nH2KwcAzJFnkc4vgtdnQa9zU7e8k2dr7BZM6Pq0UynZwMXD1/8uJAlAMcsVivlAkIbSUQKtDNHivJiUnjqHJlHLxxF8TwE1vz5f0+WX8WrJ+vN0NpumrBVHwJE+UXbbghW+ebgc0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049735; c=relaxed/simple;
	bh=w5QOrkBsQZnCr7M+w1nuSmJzfLaVPcUsUU+Ed+sO14M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u6fLg5G39jScaTjfi/v2oVY8XiAk/XeFkJyH3VTxon8qKSS/zdsR1FFKKPnv1xqeijjXoMG+lvg5e431oKEmBS/2b7TPpB8pEm0Y2mIJAefqT0ji59FXRRDFNUn9+G0KWge0KVvxq6TTjGXOQQYCQ/TYRTBHIBvI1xL1leto94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT98lL52; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT98lL52"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cfcb7183deso374087a12.0;
        Tue, 19 Nov 2024 12:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732049732; x=1732654532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAFNKtrBRUBVDKq3gLjDYKwvhPjyaMkGKIQ1dtJKNWg=;
        b=nT98lL52CBRvED67GgWYhDxebV6s1TUXmNbBvxPTgWxjQv2CX1PBZb8QufywY5Jxic
         hhdL/ficYlLfFHB7KT9Yu3XmqoBE8XpLs4108sZwQeNsZ3HSMk0uzTX4rIj9PxoGz7bS
         nvtnd3skLSjD/LGupy1LVztnuucFVkfpM3nOmDMjoWknf8TMQeEgQXGYBS6VVYMW2PDs
         KkZvfSeDYSbbMt4pLATLZT6LvIP5OPOPHwJkBf3hGPpqRQNVVt6B7QHaImJNptricKxS
         i2Xqn/+l6GGE++WBYehIvr1le95VksnpJaeHR0ZiqqMJszh/b58M8JtJpT1ZJbCMLjcc
         IHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732049732; x=1732654532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAFNKtrBRUBVDKq3gLjDYKwvhPjyaMkGKIQ1dtJKNWg=;
        b=F91S5vIB5twlm1jmd03ABzGEu24hHK4mttvPcKlJ8J8Z3z/8zspu/dQD4jGtcBX5B8
         4xt8iGiTXbWkTi3plw1vu4KuzWQUaMxGCy/P1kwHxKrZc6O9/7n8K551baePo5Gg4BLE
         uL1ftVb5fWH/rXVvMsr6xQZ6VQYOZGbRZ8ykTrLItPXmDatw8XeNMlOCsVY8q0Bbck1P
         ppV0zmHuxmP1hwTpqiMFRdh0/A2ximG6Amm6+9h0M8NrpqvkGs9nFjp8tX4Oy3M4Sj5S
         Ijy3CoWh6iTMCW4IJmwR7j4gyINJXz38x/QiJrlvo5o5E4peRNul6wCM3N4XHpbp6hpK
         Xe3A==
X-Forwarded-Encrypted: i=1; AJvYcCUDiW9vBxX93wKNhFE39Bua/049NUIL/l6xnJr7u1AclqaSMff+p5qH99Obs8x97aMMU+T2TQ55oJt+Te0q0Nc=@vger.kernel.org, AJvYcCUlMgQaICYZIFSSK9k2OlJd/7l20/9lJ8gw/hcKdmEqYA0OIslczsL1kexSF97btKKrrDjDfhvptqZkC30V@vger.kernel.org
X-Gm-Message-State: AOJu0YypJ5IFpgKnuiXukvQbSumznI4epUgeKpAXQnK3ybUX1W2k9wQu
	Ld32CL3kqFYXS0YfXwnEgjbSFzTeyf8ohknDzA6bohjewmpzCZjZrfG1Rs66xJY=
X-Google-Smtp-Source: AGHT+IHJsGLzylWE9CWQtOezfbuA1l2ST2+btHHw2oOH70Oser5nHJLzYFI62vUz8zOF50dmMCe9uA==
X-Received: by 2002:a17:906:dac4:b0:a9a:597:8cc9 with SMTP id a640c23a62f3a-aa4dca6e28dmr43000966b.12.1732049731568;
        Tue, 19 Nov 2024 12:55:31 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dfffc00sm694709266b.101.2024.11.19.12.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 12:55:31 -0800 (PST)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [RFC v2 0/2] dmapool: Mitigate device-controllable mem. corruption
Date: Tue, 19 Nov 2024 21:55:27 +0100
Message-Id: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
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
a patch series that implements this change. Since I am not deeply familiar
with the DMA pool internals, I would appreciate any feedback on the
patches. I have tested the patches with the `DMAPOOL_TEST` test and my own
basic unit tests that ensure the DMA pool allocator is not vulnerable.

**Performance**. I evaluated the patch set's performance by running the
`DMAPOOL_TEST` test with `DMAPOOL_DEBUG` enabled and with/without the
patches applied. Here is its output *without* the patches applied:
```
dmapool test: size:16   align:16   blocks:8192 time:3194110
dmapool test: size:64   align:64   blocks:8192 time:4730440
dmapool test: size:256  align:256  blocks:8192 time:5489630
dmapool test: size:1024 align:1024 blocks:2048 time:517150
dmapool test: size:4096 align:4096 blocks:1024 time:399616
dmapool test: size:68   align:32   blocks:8192 time:6156527
```

And here is its output *with* the patches applied:
```
dmapool test: size:16   align:16   blocks:8192 time:3541031
dmapool test: size:64   align:64   blocks:8192 time:4227262
dmapool test: size:256  align:256  blocks:8192 time:4890273
dmapool test: size:1024 align:1024 blocks:2048 time:515775
dmapool test: size:4096 align:4096 blocks:1024 time:523096
dmapool test: size:68   align:32   blocks:8192 time:3450830
```

Based on my interpretation of the output, the patch set does not appear to
negatively impact performance. In fact, it shows slight performance
improvements in some tests (i.e., for sizes 64, 256, 1024, and 68).

I speculate that these performance gains may be due to improved spatial
locality of the `next_block` pointers. With the patches applied, the
`next_block` pointers are consistently spaced 24 bytes apart, matching the
new size of `struct dma_block`. Previously, the spacing between
`next_block` pointers depended on the block size, so for 1024-byte blocks,
the pointers were spaced 1024 bytes apart. However, I am still unsure why
the performance improvement for 68-byte blocks is so significant.

[0] Link: https://www.csl.sri.com/~neumann/ndss-iommu.pdf

Brian Johannesmeyer (2):
  dmapool: Move pool metadata into non-DMA memory
  dmapool: Use pool_find_block() in pool_block_err()

 mm/dmapool.c | 96 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 33 deletions(-)

-- 
2.34.1


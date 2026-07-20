Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166EE3A4F3D
	for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575121; cv=pass; b=U0CE67p11pQby7bSGZXIIgA2v8efUDBs7Pvs5L7jRRhbsSltfhaf3kDVw/QocbUN9z0naXOKlqZDIevC7zuB0TUZ9RmuxW2G8NsGv4R26D4HrBhL4CWicwZfF4Kw99LeTrGmuQ0gj7c6rhaCIw055NOlznSvacAW9CKheep1Vmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575121; c=relaxed/simple;
	bh=CzOzvw9sY6kxmGwhIsCJLwfImNmbkBT0gx9KZ9/KDKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbtJRdMi1s+1y2WwmFKcoFOJNWVXHzvYqJufakCnvE5eLX2RLbsPC6eRloaAZ2sJ1wi8silZplv6JjtS3gQLlmTHA9uTHZ+OtSM/PjYPPt9aE71MPr8XShCPGP60TFtpYtAAr1zfIq/alo6u5xj36q/239hazoljH75cwuOJCK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZvsJU3Fs; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvsJU3Fs"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ccdf36f63dso417045ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 12:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784575119; cv=none;
        d=google.com; s=arc-20260327;
        b=TMMWOon6bLXTJXLvxSz2TxvcK8QEV8zkp6tzrRBtwxGnwBSWEI0cuX0X/aZ2lanusK
         U29R1jxTnccTofMh7RIMKjar70uouZ7TCESQk5ZRQeAGKoy/SIh3Ky2fx02hsusYYj+X
         vrw7LGSvPWUbttOKj7xc7qMVnIvjE8Q2ND7D0ASwNVPjBRaoJ6d/Cha63JK6PzYig2bf
         zlDrbAs8ZnZ0eKNn9vs/FoB8TJpzt/FpbIW6Ylp8mUkWwHmW544xth2qZpBuz6a8XO4z
         Xa4CANiJe6Pl6x3ZEyjQtsn+aAgvVaxq9ikdAYnjpuMGY8DdCThSAzPQbqCuNhKQM6ED
         075g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xZApkQlP3tUF+0sIVFilGXDzjCPNwegylhqk3EBxphQ=;
        fh=44qGXZrM/BmzP2A4f0CodJxv+ydiHkIjpqTtZzU4Pd8=;
        b=skDDF0XKflEBrA18TdIcDm/q57HiB5Jy2srfG3drHO9O15QkSLmt2dMVChPir36jco
         Ll/b+Wk51fZVq/CED/I4+Eu9U4QthkOapNah5BseeVqXPxXljDWENTu8tbJAs/NTYTlO
         n9eLzNxgc9nayK4/grSa2ky9UvfM9eTqjJ5LN2pVZMm2bdssv67ri1IcD6C1T3YzYU1M
         +Tneq9/owJuVaGh+pJkIuP/FtjB8REKJcpwFXv1IKmQgR5HSpw5r18eEaamz0a07wtZT
         oIoCBri0dpGhPu5aqqABIrO3AUPZqqD5lAkeq8Im3no2oyiuc91XOWXhYxjq3jn8jIkQ
         ljxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784575119; x=1785179919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xZApkQlP3tUF+0sIVFilGXDzjCPNwegylhqk3EBxphQ=;
        b=ZvsJU3FsAPRSa4YHucj5v6EVOfLO5qk8JIQqF6wzKspt3y7T6VluPADGOzTklxY3Cs
         3G3EEI+2pbjzDvIXH7llyDZXNzLnshzqIZijJh4ShctRoAo11eM8WbbfcJ9WNh4IBKvb
         YU7zPyZHZKR/ckEIsG+YNjvgDW94UHoz2gdDG+yKbdqm/piFRX8kuyHdeBR3LXhqMWgD
         7bgzfqZaovA6fvsvkddJEiCtDaewht/dNHPAENm+6Wzd5QVf7DbsUdrNdh9dg4/Ruvw6
         y+yGnNm3NGps1vkfQZp3iKzwhIIL1coXmi94baPalTDp/Y/sbGXKRtpHIMhe62aYMDvs
         2q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784575119; x=1785179919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZApkQlP3tUF+0sIVFilGXDzjCPNwegylhqk3EBxphQ=;
        b=FElZTkfHpLZtAVB4CVivOlU63tbAWa8hugSNRRVuJ75BG/OtjHW/pXCB3ywdxQI7Zf
         5qjReQrSXs9hsnGJmro8qgSi6fziKgd7/n68XfO6UueF/ckuxHnporO4k/k2HWml/nUb
         lSkWhcjqCMCbSeFpYLzE/k7gUOaUSVqON8qCcs9KAItvl1nxSmZdRhTbK5ieHL3GKUno
         NK6ywdN2A6vz3Ywn2RUoqsUmuNbxqKFD+jf0F/pNFCFARMdxuJPr3M5cU7EDyDhGbgiI
         trcCmrVlrYwa5Fgty14I1A4muE0nWOACR1lOh2ZnbxcMXNxkiArTxDqkv3xVNMrYWNDD
         nNyw==
X-Forwarded-Encrypted: i=1; AHgh+Rpbie0Dl5+sjAL2hoNUydyeklxVNfEJzvki92PehSM4D1sXYO5plV02LN+kr/KHdnIy0Kb84zBaOuqTPvQULzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbhDwRBTEINSz3lRaIPZw6Ri/14X8PPjynmceOaMQzpii2qMOF
	li1qMNMMZRVzv0kD7rjJIwSWYvgIzmDS3aiIncksz91LWCLpMSxp0ieWL59KoBts6oKcRPeetcb
	d+WQxGiauspkvvwOVFP9JtjRdAf2aJZn0nz8bPqpg
X-Gm-Gg: AR+sD13993R8KLgGal6bXXRH579KjsyF1KTwdXWXxKBSD4Qjbbjgj18QGz9Q6IJNO5k
	wr5++Xd/sLtLB2TMPV4HLWVcrsCp3Sc6xOviO6HNNfxTuJgm+vrAWAGTa/xCNQ/U+QkRa6Nee3K
	+6kkaJKaQzAQi95jxks6p0Wu39YPW7QtZcED5WLqHbuuQQ8poXu8gjia3L2cP1z0ZL4wpZiCJCo
	vD9+YOnULxmhyyZNiqhBkGeUWvYa16gGMjlnOuuHZeerRnBMA/1WlBgOWnPFXGCh1Lrb5q4SDZw
	olPkpLUnWIgUkQ1CCQD8VosOolM=
X-Received: by 2002:a17:902:ec92:b0:2ce:f9e2:4646 with SMTP id
 d9443c01a7336-2cf7b71d50emr2078035ad.27.1784575118135; Mon, 20 Jul 2026
 12:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719175857.4071636-1-ap420073@gmail.com>
In-Reply-To: <20260719175857.4071636-1-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 20 Jul 2026 12:18:25 -0700
X-Gm-Features: AUfX_mytWgNwpYQoEAQtZaZUmAoldCJ_ZYmUTMTxrjD32WIPJUFR9GJy7g5tI1U
Message-ID: <CAHS8izMocev_0TtAsUr9BqCm6sH2DBh-bPK4DfZYNEAb_d2G6w@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 00/13] net: knod: in-kernel network offload device
To: Taehee Yoo <ap420073@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Alexei Starovoitov <ast@kernel.org>, 
	amd-gfx@lists.freedesktop.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Andrii Nakryiko <andrii@kernel.org>, Bill Wendling <morbo@google.com>, bpf@vger.kernel.org, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, David Airlie <airlied@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	dri-devel@lists.freedesktop.org, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet <edumazet@google.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Hoyeon Lee <hoyeon.rhee@gmail.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Leon Romanovsky <leon@kernel.org>, 
	linaro-mm-sig@lists.linaro.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rdma@vger.kernel.org, llvm@lists.linux.dev, 
	Mark Bloch <mbloch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Michael Chan <michael.chan@broadcom.com>, Nathan Chancellor <nathan@kernel.org>, netdev@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <shuah@kernel.org>, Simona Vetter <simona@ffwll.ch>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 11:01=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
>
> knod (in-kernel network offload device) drives a GPU directly from the
> Linux kernel - with no userspace GPU runtime such as CUDA or ROCm, and
> no userspace component in the data path - to accelerate packet
> processing.
>
> The kernel itself allocates the GPU's queues, JIT-compiles the
> per-packet program to GPU machine code, and dispatches it; the NIC DMAs
> received packets straight into GPU memory and the GPU returns a verdict.
> The GPU is programmed like any other in-kernel offload, not through a
> userspace framework, so existing XDP programs and IPsec SAs can be
> offloaded to it transparently.
>
> The design and motivation were presented at Linux Plumbers Conference
> 2025:
>
>   https://lpc.events/event/19/contributions/2267/
>
> Motivation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Line-rate packet processing that does non-trivial per-packet work - an
> XDP program doing L4 load balancing, or IPsec crypto - is bound by the
> host CPU: each core handles one packet at a time, so scaling means
> spending more cores. A GPU is the opposite shape - thousands of lanes
> running the same small program over many packets at once (SIMT) - which
> happens to match the per-packet-program model of XDP.
>
> knod moves that per-packet compute off the host CPU and onto a GPU. The
> NIC DMAs received packets directly into GPU memory, the GPU runs the
> program across a batch of packets in parallel, and only the result
> comes back: a verdict for every packet, plus the packet itself for the
> ones destined to the host. The CPU no longer pays the per-packet
> program cost, and throughput scales with GPU occupancy rather than core
> count.
>
> Crucially this happens entirely inside the kernel. GPU packet processing
> today generally launches work from a userspace GPU runtime (CUDA and
> friends) and keeps that runtime in the data path; knod instead builds
> the GPU queues, compiles the program, and dispatches it from the kernel,
> so it plugs into existing offload paths (XDP, xfrm) with nothing to
> install or keep running in userspace.
>

TBH I found this motivation weak, especially since IIUC you're asking
for almost ~50K lines of code to be merged to the kernel. My thinking
is that (a) it's true that Native XDP takes up CPU cores, but
HW-offload XDP already exists and takes up no CPU. (b) with AI, GPUs
are very expensive and the work they're doing is critical, so you're
unlikely to buy a GPU and use it for knod-offloaded XDP; you'd
probably buy a cheaper smart-NIC? And in the cases where you do have a
GPU, it's likely your system's money-maker, and you probably want to
offload work from the GPU, not to your GPU.

But as far as I can tell there should be much more interesting
applications for what you're doing rather than offloading XDP. Like
wouldn't you with this feature be able to implement ML collectively
like all-to-all/all-reduce/all-gather as purely XDP programs offloaded
to the GPU? If you have that implemented and can positively compare
performance to RoCE or RDMA that would be a much more interesting use
case IMO.

> Model
> =3D=3D=3D=3D=3D
>
> knod binds two endpoints through a third object:
>
>   - a NIC-side netdev, registered by the NIC driver;
>   - an accelerator (the GPU), registered by a provider built into the
>     GPU driver;
>   - an offload device, created on attach, that connects them and owns
>     the per-queue data-path state.
>
> The accelerator ops are feature-agnostic, so different per-packet
> programs plug in behind one interface. This series ships two features
> to show the framework is not tied to a single use case (the accel-type
> uAPI also reserves "dpu" for future non-GPU backends):
>
>   - BPF:   an XDP program attached in offload mode is JIT-compiled from
>            eBPF to an AMD GCN shader and executed on the GPU.
>   - IPsec: RX ESP full-packet decrypt on the GPU (proof of concept,
>            see below).
>
> Data path
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> For a NIC RX queue bound to an accelerator, a received packet flows as
> follows:
>
>   1. Attach reconfigures the NIC's page_pool so its pages come from GPU
>      memory, exported as a dma-buf and plugged in through the devmem
>      memory provider. The NIC therefore DMAs the packet straight into
>      GPU memory - there is no host-side copy on RX.
>
>   2. Instead of building an skb and entering the stack, the NIC's NAPI
>      pushes a small descriptor (memory ref + offset + length) onto a
>      per-queue lock-free SPSC ring shared with the GPU.
>
>   3. A persistent GPU worker drains descriptors and runs the active
>      feature's shader over a batch of packets in parallel - one
>      workgroup per packet - then writes a per-packet verdict back onto
>      the ring: PASS, DROP or TX.
>
>   4. Back on the NIC NAPI, each verdict is applied:
>        - DROP: the GPU page is recycled to the pool;
>        - TX:   the packet is sent back out the NIC directly from GPU
>                memory (XDP_TX), with no host round-trip;
>        - PASS: the packet is copied out of GPU memory into a host
>                delivery page by the GPU's DMA engine (async SDMA),
>                wrapped as an skb, and handed to the normal stack.
>
> So only PASS packets ever touch host memory, and even then the copy is
> done by the GPU, not the CPU.
>
> The control plane is a generic netlink family ("knod") for
> attach/detach, accelerator/NIC inventory, and per-accelerator feature
> selection, with notifications on bind/unbind.
>
> Code layout
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> knod separates into a subsystem-neutral core and a GPU-specific
> provider; nothing in the core knows about GPUs. Roughly:
>
>   - core + control plane + NIC drivers   net/, kernel/bpf/       (~4.4k)
>   - GPU provider (queues, JIT, shaders)  drivers/gpu/drm/amd/    (~39k)
>

Since the changes are so large, I would break this work into many
series, the first which only supports a very minimal set of work
(which I would guess would be XDP_DROP and XDP_TX), and then follow up
with another series which adds XDP_PASS support, and then IPSec, etc.

--=20
Thanks,
Mina

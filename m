Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E87D20FA96;
	Wed, 12 Feb 2025 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370059; cv=none; b=sgnoPhhja8SPX3ZWjI5rsbkh+85b4D0CuUwEVTD7/wSTbme+UbtjqWxmpGjpLQNBG0zYQBDTSZjS6Wl92ezR8dsZIw9UphsyYFHna2LkQRqckKEotnuOWWB6MVY+O8wTQ/PtR6CRxkYGdt/c9aUCIL2c0Ntj1GEOLx+zAOoopVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370059; c=relaxed/simple;
	bh=PJPEdDn9ZCHCG+ipb6fYobAgNP+dJ76WARrj4izsSMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4RPCV73QBBkiD+0zglr4e8kcNucCuJF19ZIh/ROc5vjr05X5Btg4eZvm9msNTJjCCTy14pUnxDTnQim8A69Y7ZnGPdRXzf1WzewNWC/CmVMlqk6vO1IpJfWZwitSkx075QoAfHPr7ImhHRX6WkZDm/xkacXygb98c2QIOekRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C52sCF2i; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C52sCF2i"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f7f03d856so73273325ad.1;
        Wed, 12 Feb 2025 06:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739370057; x=1739974857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jaIYJxkfq1FpQvIWfelFCHR6bgEv7q45G9WBNdGRrEU=;
        b=C52sCF2ixlr7vEtt2T2GR69+mJTK2Y8fI6eEGpP4yMoLuA9xi6v3uJstRIQk9ezu7r
         Gcif16ZhMpbW2Qxaj93/o+c+hNrtneXz3d8GisvsyNkU+Fi8f8sxgeIGMtCbpsud3WaQ
         q5T+hFGPeKhjYMAlikXHw89gYdSv8kVcvsgp0nel6CLgDaWZMhjHib9JKWVpqdhCDjf9
         WbnxBsX/BM7GpWeCToN1HrHG/a7VXjPD9/i6zIt76xjLOmSgsmWo9BAFAEWRh9OyCzi6
         jPSsi2+q4ycfxhiOhVUozU68n9l5EvUjUhX4N4LKdum40gC9Ad6hSZfbVm/CY/YfOynh
         rsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739370057; x=1739974857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jaIYJxkfq1FpQvIWfelFCHR6bgEv7q45G9WBNdGRrEU=;
        b=oPOy5W4ekeBvri+QV7IC+UXZU7Kg80pHV/vLZzIDjrwJ24XOSLgPwakpVf4nZ9N3S5
         BI6VH8QMLRcnWSLV/lRcxI81nkhzGKAa194HMWXotBKy3OERs1ICZp4Myd6QFpPExaB8
         zZ34PgjSSnMkP0+5LZtUbH1Bf0OZelJn3bYxDyuI3iGnDu+nAC+9nZSQWfLHzm37EwTT
         7/fMc2XoZ9ei0fN4r0itmewXMH3RhLGBeayBle9s6hOT6eQt+2BdPVL00MGhwKzEDXAE
         z497EkJdIMdy6zIr/suEfjzzowv70+rS8sszm3RuSHWkT7mD2H9eMYAJMnoLdhpfPfZS
         fzig==
X-Forwarded-Encrypted: i=1; AJvYcCVh8aYCNXfClpglqRaZOkAPLqp563NIdLpvq4W87kmpkq93ddIP5vler3fbbenhi+upyEk0xql9PxKyDG/myTQ=@vger.kernel.org, AJvYcCXBuoK8QLtaON7vO9lyeNxrZXrhsfiSDmG40GJFMDUQmiywW/RVHczG+P1T0M6LuYjOf7ngcTooLSAe6324@vger.kernel.org
X-Gm-Message-State: AOJu0YwalvpHa7HhFeb7ywCGryHZN1ZSRa4/aBMxbmRoICrQGFtWb6Qm
	muvLk7Pgqv4jR8HuahxXHXJJ95aDTTgDHzTCLnA0cQX2uzx82z6k
X-Gm-Gg: ASbGncvT5QmK61g7TAKxsemKPMpvrv0sbMkP61fGK2SRoHuY02twg0HU0vqieHR89fI
	DWlCNaEp4SN8XrrVEfSv2f3FsYTYFyqNFpZOJoY7lnI6EeMhUXciEwMh+MLhqK4yu2Y3PVybTGs
	WF5XISGlDVDxt8A/2j5EEV1zTLHR0Q5FZljIGx3A8YaJD8GOctoDRkOwRDoVNa+paSKCYVB72lO
	SEXsLe9fMn6XY+syHMV9jwiE3PZXTYJ0G1TZ1ATiJi2LKm6kALNoqQ8qqHRTMFGOPX4YBL3Iv8m
	mkBCmA==
X-Google-Smtp-Source: AGHT+IELAEQ3Su7Uqr4OcDRN0pXjfLjCy12n0YoT9VXRC5Czs6XS2YZHik4XXoqANjmviTX4+vCgMg==
X-Received: by 2002:a05:6a20:9145:b0:1e0:ae58:2945 with SMTP id adf61e73a8af0-1ee5c822982mr6803627637.31.1739370056948;
        Wed, 12 Feb 2025 06:20:56 -0800 (PST)
Received: from fedora ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048e20c32sm11487073b3a.170.2025.02.12.06.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 06:20:56 -0800 (PST)
Date: Wed, 12 Feb 2025 23:20:48 +0900
From: Harry Yoo <42.hyeyoo@gmail.com>
To: GONG Ruiqi <gongruiqi1@huawei.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Kees Cook <kees@kernel.org>,
	Tamas Koczka <poprdi@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Xiu Jianfeng <xiujianfeng@huawei.com>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Refine kmalloc caches randomization in kvmalloc
Message-ID: <Z6yuQEYJbmWi8z23@fedora>
References: <20250212081505.2025320-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212081505.2025320-1-gongruiqi1@huawei.com>

On Wed, Feb 12, 2025 at 04:15:03PM +0800, GONG Ruiqi wrote:
> Hi,
> 
> v3:
>   - move all the way from kmalloc_gfp_adjust to kvrealloc_noprof into
>     mm/slub.c
>   - some rewording for commit logs
> v2: https://lore.kernel.org/all/20250208014723.1514049-1-gongruiqi1@huawei.com/
>   - change the implementation as Vlastimil suggested
> v1: https://lore.kernel.org/all/20250122074817.991060-1-gongruiqi1@huawei.com/
> 
> Tamás reported [1] that kmalloc cache randomization doesn't actually
> work for those kmalloc invoked via kvmalloc. For more details, see the
> commit log of patch 2.
> 
> The current solution requires a direct call from __kvmalloc_node_noprof
> to __do_kmalloc_node, a static function in a different .c file. As
> suggested by Vlastimil [2], it's achieved by simply moving
> __kvmalloc_node_noprof from mm/util.c to mm/slub.c, together with some
> other functions of the same family.

Hi, GONG!
Sorry for my late review.

This patch series looks good to me (with a nit),
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Also, I verified that the problem you described exists on slab/for-next,
and the patch series fixes the problem. Please feel free to add,
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

nit: Does it make sense to call __kvmalloc_node_track_caller_noprof()
instead of __do_kmalloc_node() to avoid bloating the code size?

My simple build test says it saves 1592 bytes:
  $ ./scripts/bloat-o-meter slub.o.before slub.o.after
  add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-1592 (-1592)
  Function                                     old     new   delta
  __kvmalloc_node_noprof.cold                   39       -     -39
  __kvmalloc_node_noprof                      1755     202   -1553
  Total: Before=79723, After=78131, chg -2.00%

> Link: https://github.com/google/security-research/blob/908d59b573960dc0b90adda6f16f7017aca08609/pocs/linux/kernelctf/CVE-2024-27397_mitigation/docs/exploit.md?plain=1#L259 [1]
> Link: https://lore.kernel.org/all/62044279-0c56-4185-97f7-7afac65ff449@suse.cz/ [2]

-- 
Harry

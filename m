Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e3Sp0UD+"
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD12C127
	for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 13:09:02 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso1216500b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 13:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700168942; x=1700773742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xYAFY96XcFiMxIF+L4YoxaW0MbIDBtwFnVJcSIPp9Co=;
        b=e3Sp0UD+6Xyg6NDUJEif0hrLYx0CML2C0FUMAMVe2rcdU9lm0RoZ4CwzwGgSE0gQgX
         ns3/QTMffLN4JkMiWYdYl4tZszTywdXBDKrEKrL8Nn77J8k/iIT2a/K1glo6bdxPpdBf
         pQ9wlLCC+kQaurxjYR6qdQ0TkxLzlbP/2nmoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700168942; x=1700773742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYAFY96XcFiMxIF+L4YoxaW0MbIDBtwFnVJcSIPp9Co=;
        b=hb/ZQZp7JIwwNrq3Kn/UnYdO0NhsUyd/txY8HLVa9i51fEJngYe85245jZ/Ow1k5vm
         TeA+0+WKpv9FDkIQEOptqGosPOCgFpjzQMfZOYn/sb6ARR8xaNOpBM4LwGFqXmY8G5+O
         IC1FAhP9kv6uMtSnaemZVtT+fi1jdvg8tdlFqjz/3ALG9ZOhEnIL/+RPb9HcJcZhAxku
         TanhcbERzTAnEl7ot9FTAFmMxBaKbxriojj+AHd3WNdLl8HALbhaPcQoLApmbraGMjlT
         uTZJwFVsrrqtWicLRqzIl4SmECpMldoiIeoyfyYvAl/FGa/AFWwEOtSsLzoiQh0/FOYG
         xJOg==
X-Gm-Message-State: AOJu0Yzh29GlOpsbVARV0Fm6BZ7O7v5XL2RRnrDjca2oyEjzdHcMgGI2
	YIvhHDqDRIvRVBweMvvoXdw+oQ==
X-Google-Smtp-Source: AGHT+IGDMJWNBh7L3/s1oXiCq33PVVTLiBNbt/MbNP2Jg71YOV8F+by6BxzlVI3bHz3WEwpQvMCriQ==
X-Received: by 2002:a05:6a20:12c6:b0:154:b4cb:2e8c with SMTP id v6-20020a056a2012c600b00154b4cb2e8cmr18208401pzg.24.1700168942326;
        Thu, 16 Nov 2023 13:09:02 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j12-20020a056a00130c00b0068fece22469sm175211pfu.4.2023.11.16.13.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 13:08:59 -0800 (PST)
Date: Thu, 16 Nov 2023 13:08:35 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] xen: privcmd: Replace zero-length array with
 flex-array member and use __counted_by
Message-ID: <202311161307.9422E1896B@keescook>
References: <ZVZlg3tPMPCRdteh@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVZlg3tPMPCRdteh@work>

On Thu, Nov 16, 2023 at 12:54:59PM -0600, Gustavo A. R. Silva wrote:
> Fake flexible arrays (zero-length and one-element arrays) are deprecated,
> and should be replaced by flexible-array members. So, replace
> zero-length array with a flexible-array member in `struct
> privcmd_kernel_ioreq`.
> 
> Also annotate array `ports` with `__counted_by()` to prepare for the
> coming implementation by GCC and Clang of the `__counted_by` attribute.
> Flexible array members annotated with `__counted_by` can have their
> accesses bounds-checked at run-time via `CONFIG_UBSAN_BOUNDS` (for array
> indexing) and `CONFIG_FORTIFY_SOURCE` (for strcpy/memcpy-family functions).
> 
> This fixes multiple -Warray-bounds warnings:
> drivers/xen/privcmd.c:1239:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
> drivers/xen/privcmd.c:1240:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
> drivers/xen/privcmd.c:1241:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
> drivers/xen/privcmd.c:1245:33: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
> drivers/xen/privcmd.c:1258:67: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
> 
> This results in no differences in binary output.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right to me. I can see the allocation:

        size = struct_size(kioreq, ports, ioeventfd->vcpus);
        kioreq = kzalloc(size, GFP_KERNEL);
        if (!kioreq)
                return ERR_PTR(-ENOMEM);

        kioreq->dom = ioeventfd->dom;
        kioreq->vcpus = ioeventfd->vcpus;


Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

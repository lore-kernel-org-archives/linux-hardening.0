Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333155;
	b=YL8YTrH0a7LVOiGGHr5ZQ6vTuIHZ2FVP0m0bQ0CXtkhkIvvuFHBnBs9uNO8D9Ex3wG+s
	 TPKJxqQhuPvf+P0EK39D0LY2gPR8wv6l+8G3kWsWKCN2f8uAMCzMkYy5O8q65FV4zpRr9
	 cWSajtxGv1bVizEFPmeQ2LKtCrwqmL0gp0s/4KFqKNOd8lo0G3gDLc5id//ezHkhci04M
	 rANrBVPu4ZwOcfenrGT2WVFetfihQour+mALvPzG4fJYfTTsrffE0wn+ampARlcEVF9ao
	 X3HuqHVKVj8yfRSjgwGg5MSPuIppLPQTkS59KUJz+hvX5gvQKxqq0lyKSgZux9DfH5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
	b=nlIHC6gkZUi81XQfgqTSa+D29NKD0nJM9DY4LZ9CE2c7wWqyiUA7HLyePCNZoIWteCN6
	 uXi4S1eAxBr7VCD0RVXWiza+UVSXWoiDdtIL8tMlv5awtHqXyBuGn78/Rn5heXfbhQaA1
	 g3XQcEWfyD+rvSepjBqiNp1db6Ue0IWGiUYcuhZjj2ZhaMzJYa0ZXri4RqAkGbLfhVBs1
	 QqkMoJbKL68nlLenlnRL2jdjwHSeJBGuIWJMV8IjPzD8CDfH8AdcrUExE4TGJOJl9jPhO
	 b82wHs7p7kHvDRQXPwjFJ3KJsy/v3xbSwf1LkwWIpI0Ic13BdVBnxq8bIHWgBFl6j4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="cZUI88/L";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F469606A31E
	for <linux-hardening@vger.kernel.org>; Fri, 30 Oct 2026 04:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F469606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cZUI88/L
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so632148eec.1
        for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793333154; x=1793937954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=cZUI88/L9F1F6vaHkoJiPubaFvpBx9ZOZoFIH4WzYEl9uT8+1501kBXRQ+iQnW1rG/
         4Fw7u6pK2bhGr83aiABmILWeko3myUezgpD4yxFu1q8ofu7DAw3nd3xwaeMW+dOR7WjW
         fF2I6XSi4uBYslctXHDwkVQCwzAYXH2+VEB4ld4ijUFXCUVYiKPoDWGSOArpmY2b6MgQ
         9ZvnqUJjjMcJdZxPtAbFTkDp6O48lwLVb7JSCvyQcehPpzJbJ6jeHUnZCR3iOiOfxhs1
         cwBXgsfbLoMorO9ZFOLAr33BI+k9rnycgZilL+r2ECnd+fRbSczk3whlomOJkp24wZFS
         GQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333154; x=1793937954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=fsu18Xcd3O9PWvFGWeMD1t0iIBeOiMQGenv/HliqptDfWtQ2M/ZxSg3QunESrVhGrP
         p4o9DEuDuyEmvE73qwrfU1UL5VAZlAuPpl5Xo0jIWC07SZ5G41C8PNTMvyURDjLxjKn8
         dwApuQ2vq+na87KLLg+qyguukG+6eAmM5kLo4QjkX23S5ju5QE5yAj5+Qf4cimLDO22M
         Gq5RbHfxeNQG+aWMZh3asa1QuAq9yUdDfzNftOjvBeQ1eJ6tDrJiyGApLsZpNFuhGpnZ
         LVjiv7/ngZoiaAJOQz0qWmOhNfeaYjmfTf3Q6cIZDyVbm9fOhAHccGFbSjntuD26nm9i
         s8zw==
X-Forwarded-Encrypted: i=1; AKwUvBzOrouPbd+6smrnFg5WPSv5/YMEe98N2QTzRjr2QNHBUb1ggws2RsZegwrLE2TEzqUYwDYP2bqJFH6lHJeSjo4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcIoXydf3Yojb9vuNIDCqOiu1cO9egjwUetV+YTvwxF646FbDB
	m/1+h/xr2lTw5Kd3eIZOnSuiPKcBYK8n+C84/hO0zTdBk41fG2VLyYujkjIp1a6ysUI=
X-Gm-Gg: AYBFou0HJgWTBTRSsuh9VAwR7RKWhtzn3cKBPHUnoklf1tCimtxYawfTX/EJMQEdMUo
	e0oHHekJHSGydFVCiaZ3vtW9MyVfwfprZevLp17feiEZ7briaX3YeaNZoVJG19VfIxf3JsF3h/a
	6Mdcjdi3oSPpWhWEYYUuFtUjKTc27F/XemghyqwoZBiHyRHzwmz3omIL/fS6J5t6c+1aD5+cB9S
	sW4LvlzPHyyUU6X9grwM59POu+OPiO5GVq2KpaXocfGJgGhLPTt90tRQ+KTm08SSFpv8Smutiet
	ng6Baf32uJnW+GMcAYl8v4jWimNpcGegxF0saMhOzTDAvbpnrQ21l7wndf4l05CdmFpoLuRHxOe
	jY/fYLke292WmPvY6Sy0fMD+W3wCKNPY8MGY9AsC7yHHvS7VISzCyn2xSgzg7SX5ACz5jDN2RXO
	sggCqPwlqB406ckaZlgPphhJelUwqjJp66xt/by+vG/ZmWCT6apTWfCsTbqv6/B1MnfAQu5xoK5
	4PedqeUZNX1p90cOYM32DCyVtvFwoOhMue6rFVD3g1K2thHpQ27z449GNz2Wy9Ubv9V8hvij4FW
	zMvBpeccRXUaBxxX89dpMBgBM2+5Lus=
X-Received: by 2002:a05:7301:53cb:b0:35c:e696:2d4a with SMTP id 5a478bee46e88-36a423ea99dmr1772736eec.24.1793333153319;
        Thu, 29 Oct 2026 21:05:53 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm3512579eec.15.2026.10.29.21.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:05:52 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:35:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
Message-ID: <auQXnep2xKpuNJOF@vireshk-B250M-D3H>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
 <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
 <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>

On 28-10-26, 16:39, Rafael J. Wysocki (Intel) wrote:
> I'd expect the driver core to pick up the series as a whole then, so
> please feel free to add
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122402DC76F
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754101; cv=none; b=Jh+wI7YwgVMxCja74fEF+iXD8lyd7gojkiEy+GdpH3O0T9ztn+isSoieoR+widp+jVTLaEMm+5FJ2s2a9DEcRVXN3IiAsg/bZvDstpW8MBlETrDVPAVkLh1lgzJhp7NiWZ1ycjA56n+luGyi/Db3EveP6pKrnXH2hdcpRMzivKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754101; c=relaxed/simple;
	bh=/xngWsAkOy9HobrmWI3BC7n9/5gjXHqZsjIulE6+O9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLkPezlPDA6/y2geFq5EEFEaPkB4n3hWw20qAiSA+BUYc9QGCvkBfVLhTj4/gfiR5Nn5RunaHOZ7dJ5OR1UaAzpvRV0YL3/FaMPuTgpfE11N9y2X2FNG/NFWbE8Q2RQTQW98E3+RN5DH4w2tqY4fgsC9/Su2C0ZzR0ouRs8Xovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mCIeepw3; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mCIeepw3"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-882399d60baso18100626d6.0
        for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 11:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763754099; x=1764358899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=leQSmYI6CaqvqUUCRW9PtNRuz9kC54AWbM2rvpXiyIU=;
        b=mCIeepw3DvxvplYRcKk8sLOzK9gcUaGyxcMYAc5rbHPsOnCtreFJRBuNjAh0lKrfUs
         gS6/afQ5AbUo0t1MOzk0bA7UtPs0ZCZJ3d9zvwxDiBMC6wP+EAN1MDf0juRC6YRJS/OK
         OWokQLPx4LG1+B6yDtnMS3j4woh/B3qm0Mb6p9Zb3HERdCpcAaTt83lkxVL+UUrewoyq
         3FGI48b1YC1KkH7P7yipLpMWuCNocHKeZhj7Z9CUKbC2f2AzVzWf3tWcv4wR4U43wXUV
         fDOcDr6WvMUpZV2Q7siali+hm3FWRLmTqz+podRt+C9/g9aP0O/u3GbAxJpAZv/upKDb
         GSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763754099; x=1764358899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leQSmYI6CaqvqUUCRW9PtNRuz9kC54AWbM2rvpXiyIU=;
        b=oLdXjtvtSrF4Q6LEexik3ofg5b7zFgLhkRKQbwJf05qaTPAzLkJCLMWhRxqZDp8ASH
         ZG4fftHikVguPgVCMZqSW48AzRah/HLr20KuDmivE92d4trGnMuEglx07F3eh2dfyY7f
         vO5UGdhqFhE1nXvdogRKY55GY8juPAK6kzjBLS6MmTkcWAa5nts3NY6C3mfshnSZbMnq
         ZjLX3gcRItl40mvtwCKOkdTpXghAM1CIDxUObKjte5o7oayW0jz8gzi7l2MTlQvrfeyl
         0MJPVTmrx1ZLqdaH7iMRViRXgxkqfmM2bvAR7is9XJad4HMIJbhlOdKsvDAaj1DvFcnX
         0GUw==
X-Forwarded-Encrypted: i=1; AJvYcCVxRVB0YqOPXmp8jdO8GgXjEz/GVMW7UDaTfTPIOzCgkkCux5pSeQNjn7GQ6sKMATqruG2Gvs2Cf6HYTzdmwX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUY/uL1YwwfeVLtyJdUy7A8B6OdWUwHxz/SbsbLdzHGBk7sCK
	8LsmGjQsAraYL6/sKrPvZVCPZs+EzS81U2efO59kcTIEcISwsjU7QZRTpf3LmLX/tdQ=
X-Gm-Gg: ASbGncup/2h7xF2e4GNXxx/R1up5EYPFlYTN76JLuHnS+VTNXNHknarSzoVcy++gA1b
	afiiYnyEAjsvvO/buWXVywH8yiCMPuQIDSECcOcHZcjakFuWosenbUf4i4EZTwZMjlROoGZw8mV
	pPse4RI398ePg1rtvibemYCjGjJURJd2nqdLrRbdgRqIWnxIHGRwep5fdFNrrlBhaO/zl2llf67
	euklHd6j28YgkpoS3pnHuQ4b9uNc9ll6r7SixJO//EYKluznljGf5yrhuyoNzKX1x4BKQv2lqhZ
	rNNd9N/wACAMjANwywsdyMZOBLpkrkLdc3mrEym8vdfwwcdRTNf3mnFqLJlbli39eA/n31J3H9+
	aIH0tq7cfZJGAGaGI+BON/p+vtXd//Rbu4LbLsU5+U4eSR7sT7BeTRcgo2vp3zv+0pTfduP9sSG
	CE4UmUy8BAPATUSyC7mdETkytlE7St3xI7+Tknnv93BXiVw0PMfL5RqCws
X-Google-Smtp-Source: AGHT+IFYiwlmP6Q1uBxpUaEOynP+GjSDM52BYOjVNB9E2WPwnPj4mnle0F2KVfZAXkj9LJWK5a3vYA==
X-Received: by 2002:ad4:5aae:0:b0:78d:be82:fffa with SMTP id 6a1803df08f44-8847c5482e6mr65937506d6.33.1763754098808;
        Fri, 21 Nov 2025 11:41:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e469825sm44534696d6.15.2025.11.21.11.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:41:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMX0j-00000001aQ0-2Qqw;
	Fri, 21 Nov 2025 15:41:37 -0400
Date: Fri, 21 Nov 2025 15:41:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iommufd/iommufd_private.h: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20251121194137.GE233636@ziepe.ca>
References: <aRHOAwpATIE0oajj@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRHOAwpATIE0oajj@kspp>

On Mon, Nov 10, 2025 at 08:35:31PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the corresponding
> structure. Notice that struct iommufd_vevent is a flexible
> structure, this is a structure that contains a flexible-array
> member.
> 
> Fix the following warning:
> 
> drivers/iommu/iommufd/iommufd_private.h:621:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied thanks

Jason

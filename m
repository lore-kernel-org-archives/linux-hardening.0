Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E982FFF81
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754232; cv=none; b=Jwzb/RXbklsDZ+lC0Xh/jpZS4/6n8PFy1t+YCa9aREop2UdJZrjq06GapqDobQGo9eRG3W0dwlw0D6v+JnJoiV9yCONVXOyd6C0q7e7+B95ussVMvPy6qJ5C5a6q9bgN67lFMFLQDeSVrBsX+7B3OGnd7AX9IiRaUUe5vyKAMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754232; c=relaxed/simple;
	bh=Vasgf9iDnOBSzRsjeFpKd6WXdPHbFWwhpiKUPv24uSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry9ED2CIbg5rq60yoWDiNKE1j0BMr9S66aQ9wjoqdD3zqSC8negiizUiNcTBtIGJRdPM8tqWAeN8B55vZLUVdb/61loAdR42Dca6FvvXQ/RrWNTJMzo29XJESbbj50jCYeSNgRgyXK44I8Y+N/pNDMpVVgQhKvNBRINKfLi8FxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z93aMA5g; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z93aMA5g"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88043139c35so22622896d6.0
        for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763754229; x=1764359029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+QgWiw8/91FDKWyOytQdo9DdOX1N/C2KE/jXm9rwyZI=;
        b=Z93aMA5gVCvd7BUVKhCtZoFjNXBiAnHODOFBNQYOgjHc0c5n3kvFA88ZHrzC5WI9it
         28bxu3yC7OWnO51Sg7Pd+CjAWNTDzoxv6RmK2DmxdI40OY0pAZb0zOcMHPyFaTGFeNBn
         QEAV9Y8PHzrDnTkv0RR2LReNbk5GWaO0/mWoeJf7SCDEwy3A2vKQmQmXfzP60WcAW9b3
         GANKZ1Si7T++0lkvfLFL/z30hcE8/Tsk5PYUJCU36TAhJQCq9a63CP9pGpy2+NLvF2kt
         /2zAPStyLZClTb/JqNuu2RvKCkaOTtil0HVfBMrxN5Wo60+GrZ+pAy/HGaU11IJNH8jk
         EZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763754229; x=1764359029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QgWiw8/91FDKWyOytQdo9DdOX1N/C2KE/jXm9rwyZI=;
        b=w4ttH3EnjUI/1/5x7iLE6ZrSyuj7C5pDT0ub9b//eKLvUdCAXpKLXx3QWXlkDZq91Z
         gENzZAXvgNQg7s+plIkJU+tUxeOHz1aHKllI8NtYk4KVbPbMVVJ07O6InYBmD5dBdKJi
         1AMaLfafaKVTt023d94wUkSkqWZdKqKbhXaTwQ1kFRqvPcl+Ym6mbZmFX3TWgraRWMLf
         DVbMqyl5KQiGQq+gljij2T/mZkyXLmVTrR/by/rCaWR3yEdAGrkHuQYXwKUyZvnutYdd
         EzW9RGCxBbwIwMdGeVRECaj0ZQgk+tuuJ2bNQ9M6AgjB5snd3Oh7Wjjm9Nvpj0lg2+iD
         AWPA==
X-Forwarded-Encrypted: i=1; AJvYcCUdRashIek9fqZ7omH7X4ZSwySR/7g8N1E3OxQ0hI1Np+jRw/FkfLxfZbFqKEximcoasRgqPpqQVzMEJa3I3ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRTQRSpRDQ4DW+HFwdvbSaalR2nkQKP0jkMFktflkkKaWg2jib
	0zXRsESvkxYcwyzYi/lIPJS9fiZHpHafjuUe++bxAVuwiAF4/48+8xnCv1eXOyoFhwQ=
X-Gm-Gg: ASbGncvvXpfYKA4G/qyW/OiTaoyB57ApbXHn0CketGEAjMP6Yt7+bfFk/BrOcD9eNhy
	FIN68XIaBi9WS/D4hW6k7edA/Z7M4129/cKbs/6fta2pFrdttVIhPDuM1s9iEeavm5cnzxk+Bd1
	Hdv5u54DZfSM+WPG5nPu0TqetkpLNobwCYK2Rl+42KUyOhLFIh/qH427o8iy4f9t7LmDLxIeb32
	+I4sWQ6UUKgqNcMMqXfPZYiYnoiefp48AXKZICjq3WtXhVaI6OmJWxsFUne/k0sBUjiIII90jM0
	HDkc3RsC+iqw+pa0z/apVGcJD29GPC+sxr0Jas3fd06PshU2ykop3exgAzLoSaQ9Nnb3zb6SBZZ
	/CJ9c5oCCAX32mgP6+CP53zY0ID+Ee+456M/n0Qf56ZsJwTfG5DJa6Wb6YdODR3gD2aP1pw4gm2
	liJ3gE940+g3AFlrNelV6Ty2zB/12YM1suJWUTABVypmPTcPaJxyL7yPdc
X-Google-Smtp-Source: AGHT+IGqc8b5OqtPTf0L+qTFhxqvDfLDQaT2MVNMs6H0B2nCSGrUCWV8rdwz0XmyTkzH+nMbULjcjA==
X-Received: by 2002:ad4:5cad:0:b0:880:52d3:9c03 with SMTP id 6a1803df08f44-8847c520c97mr64807786d6.33.1763754229556;
        Fri, 21 Nov 2025 11:43:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e5735a8sm45639656d6.41.2025.11.21.11.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:43:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMX2q-00000001aRf-2Fb9;
	Fri, 21 Nov 2025 15:43:48 -0400
Date: Fri, 21 Nov 2025 15:43:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommufd/driver: Fix counter initialization for
 counted_by annotation
Message-ID: <20251121194348.GF233636@ziepe.ca>
References: <aRL7ZFFqM5bRTd2D@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRL7ZFFqM5bRTd2D@kspp>

On Tue, Nov 11, 2025 at 06:01:24PM +0900, Gustavo A. R. Silva wrote:
> One of the requirements for counted_by annotations is that the counter
> member must be initialized before the first reference to the
> flexible-array member.
> 
> Move the vevent->data_len = data_len; initialization to before the
> first access to flexible array vevent->event_data.
> 
> Cc: stable@vger.kernel.org
> Fixes: e8e1ef9b77a7 ("iommufd/viommu: Add iommufd_viommu_report_event helper")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/iommu/iommufd/driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

Jason

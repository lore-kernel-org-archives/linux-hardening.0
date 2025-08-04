Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402F23ABB9
	for <linux-hardening@vger.kernel.org>; Mon,  4 Aug 2025 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754304901; cv=none; b=r0UZLnlMEdBMYeCuI5hBF9XHU6PhfA25c0ygEMjS5d9qyUXDUUkhzSxFPXH/HMNKFYO2La5WRQEe8k9v1JgQx6cXCVMlJMUnloZhCHERyqg/1qVNDxAEimlr6W377NFVamV/6cGU/xHOAkyt0dGvuWj2AdzeBm7fTJrk7zOCS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754304901; c=relaxed/simple;
	bh=G+iM+Wpdl0pGgQeVVC7j3IxrRVcCkNicU048+veoUgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmPV4N4RZBH0Rd4mELJIBn+Qq1u/2R7PpY4naMcIxV3rNYTh1Pxubk6pa9+yS036XcqkYRy8YOzAhj3ioYw3iZpAGjddZgiIJTP7DjX5mmLtVQMKyO25b++WUr4GB3ZSEIo1yM9OYY0Z3ZtaS9QHidMEjLhH5n7ZeA/fCKfkfXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KjHAF4QH; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KjHAF4QH"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-458ba079338so12734505e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 04 Aug 2025 03:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754304898; x=1754909698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jTfwzKdFO4Billpr1agzWiIuczhIZbl+uk2TO52W1Ms=;
        b=KjHAF4QH0Xq3WzB1V6Lk1wY1jWkCezSxD8TSrXxdraxLoF1Gd6k9cHY5qG9HVc8s2c
         IcwIzxQVcKUEzprmR8GwS1sPZEZBgQ9HrZgl1qoH1Uu2GCcQ6hUq+XwZxs6Ij5J9GWmw
         04sJF3TjdLl51ljDDm7qHuj/FRhO23HelnhTogfZ7ll6ruTpQA0RUctj8gW8Wd5dj0yu
         FMp4TV23n9ZHGp3MG6KZQvixhepVLCr9HtjCTvvHTSjvEy8rPX9l5BashWrS8vA0mNYg
         0qHaZZrduEpS/BUx9ESYSNqTLleGW14jG3yyiTKKYp8cwuDIOg6C64kjN8CyLWQWmJtH
         soLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754304898; x=1754909698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTfwzKdFO4Billpr1agzWiIuczhIZbl+uk2TO52W1Ms=;
        b=kl/vccYbxnbwp4JsDeZwLUeVUVdkqmSFRwxFcdCqSgpANHiXn/xcFRBXSyx+c8khqG
         kgLmCWeKXKtbsCDfcO37aG7Gsc5QiH+JZ26Jy+wvsr/OOe1YIUotW/mvg4iQWHSfLL60
         2z0MiIZrBXOIel/dv2Cbf1xFnE5i3NsY5GUoF5d2YWfsTcaCy22bpWsFDDfa6TLOrxDZ
         wE2awV+fB74VGpjY4WTv1qqfiTKkRF3bFBXPnSFwVqzI9jUe/FbNHAzG2w4A8ecHmRec
         qgrPJ7jlM3aupKykOcEV+YxcYfj4abbPbcciVAKb5FOTrP+KptIJrKSggoK2YZ4UoUhP
         HWjA==
X-Forwarded-Encrypted: i=1; AJvYcCU10b1E8aSLy+AEiH2wBait8EtkD4Z/VGi+edQd8geW/1vzs4HORV7+zCugiHSI8+ZyxRFvesIbAULMsasxKUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyewkG7bLN66QMhFukHjA/IC73oWYraIM+hvEY3IH0UuAu7t9E
	5mpc8HAQNMOPY8j9JcVmZgezyBBCNnW7XGMi3RKXkeYlz5PVs5nXonilAdZmAXXlnds=
X-Gm-Gg: ASbGnctVz8ZOo/F5TU3/AsAt27VhMYelzJHeBb4B8+5BmX+5L8ZcpWei5S+/WGc8AgA
	i0lhcl76u9HdtSM4n4e1Rv1YaFwjC33ZchsUVfPZx1Yg+NHg4TXvcOGjG8lc2uCqSh413G+7Ll2
	tQkv2xiJLzcXrLpIcNXHrcFoxyeS2WPWd2s6JHZL5cPHlzsCJChMotRv7kMV003Mxq9jx8ssiqs
	7/PXHUU6E5TXut4aMYZuTXKOXKl7J/DYzhvh/vJCegwzu5K2gLA5FH5mrZz50UJJUnBs7lEWuNx
	vjU+0tmECagb+v0CmvaXpZiiEi5N56M6KEBmqJlhlkQJ49/nOYQANuzPinhXEDr1L6RaE7RKpO0
	sVzy0QaVTi+PLPt4yMdIYSYx1OYMSmQryinJ6BRatlSjJ/2V3ubiolDO1UAFJi+7TxkpTx3xeYO
	GYbFJ81f06DA==
X-Google-Smtp-Source: AGHT+IHolr1jpSS8jZ3V5wzzwBRxkUohemu1Nv4CGTNmDUpUc5jSaT3JjX0JSbIFj/1+2LYoFZrMMw==
X-Received: by 2002:a05:600c:5246:b0:456:1281:f8dd with SMTP id 5b1f17b1804b1-458b5f190f6mr71240945e9.12.1754304898475;
        Mon, 04 Aug 2025 03:54:58 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-8394-58e6-9e1a-64e5-71bf-cbcb.ipv6.o2.cz. [2a00:1028:8394:58e6:9e1a:64e5:71bf:cbcb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c453d6esm15241180f8f.37.2025.08.04.03.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:54:58 -0700 (PDT)
Date: Mon, 4 Aug 2025 12:54:57 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
	pmladek@suse.com, linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, corbet@lwn.net,
	mojha@qti.qualcomm.com, rostedt@goodmis.org, jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
Message-ID: <aJCRgXYIjbJ01RsK@tiehlicka>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-23-eugen.hristev@linaro.org>
 <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
 <e66f29c2-9f9f-4b04-b029-23383ed4aed4@linaro.org>
 <751514db-9e03-4cf3-bd3e-124b201bdb94@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751514db-9e03-4cf3-bd3e-124b201bdb94@redhat.com>

On Wed 30-07-25 16:04:28, David Hildenbrand wrote:
> On 30.07.25 15:57, Eugen Hristev wrote:
[...]
> > Yes, registering after is also an option. Initially this is how I
> > designed the kmemdump API, I also had in mind to add a flag, but, after
> > discussing with Thomas Gleixner, he came up with the macro wrapper idea
> > here:
> > https://lore.kernel.org/lkml/87ikkzpcup.ffs@tglx/
> > Do you think we can continue that discussion , or maybe start it here ?
> 
> Yeah, I don't like that, but I can see how we ended up here.
> 
> I also don't quite like the idea that we must encode here what to include in
> a dump and what not ...
> 
> For the vmcore we construct it at runtime in crash_save_vmcoreinfo_init(),
> where we e.g., have
> 
> VMCOREINFO_STRUCT_SIZE(pglist_data);
> 
> Could we similar have some place where we construct what to dump similarly,
> just not using the current values, but the memory ranges?

All those symbols are part of kallsyms, right? Can we just use kallsyms
infrastructure and a list of symbols to get what we need from there?

In other words the list of symbols to be completely external to the code
that is defining them?
-- 
Michal Hocko
SUSE Labs

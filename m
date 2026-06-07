Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784A2D8370
	for <linux-hardening@vger.kernel.org>; Sun,  7 Jun 2026 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848296; cv=none; b=ZZhnNvqum085AS8FE+ByGGusvhDEs3YIAz4swTauU27C9tNucdFifM3HrltBjewu0XDSX/cwPDDJ8H3vKIuuNetxYKUGQSlEvyEv/Fc9B51JIjKfQxRZPx38Z6vCti7uq71XstrqkgvZ/1M8+aGLm3ORgQc5uGvVXMAdKFSa//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848296; c=relaxed/simple;
	bh=eK8MSldLeofL6fbYcJNtrJmeIPFDwpepphNpG1jidfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5Q7w178aU9bDmZbf5I5EzF8WCbg9axfvbFehIYh39xVt6N6uAWsWa9yniO8FEfA+5NpXqq/Dlm6zNQgbC32eD8yXOKytaowv/okBXSoqY4E4Q55F1AXwqDtMR0WWmiReiorWdOxHm/vdEQe0WttyehSz5kAA35Zq5qtNFYBccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG0tHHhG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG0tHHhG"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef29c5561so1802671f8f.0
        for <linux-hardening@vger.kernel.org>; Sun, 07 Jun 2026 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780848292; x=1781453092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eK8MSldLeofL6fbYcJNtrJmeIPFDwpepphNpG1jidfI=;
        b=aG0tHHhGNddc69ovQ3FRnBPZM/RXmmkhftdY7RM5+GzUdqU9kM/2gpzYesd2VnqwZP
         2DBYb/DzG10Oi3fOda7YDtoKosauph+IG1DGDL2835beDtPznMuhF0zl2A/ealE8hlti
         m+CIzK1z4iyxH7jEjySRohbnsrSMn6oxX+tpd1/35dTx9ECHD+CMRWniSQRUqPoQAXXZ
         JjgG5kLgYEa7UqkhvCnBmlzYsnya5LTwy99pwS5J+fvVqIdPegrcNqfvMrs1mvcbtuMP
         O9Pk+Zju0eiX56vkCedxvesaCLnKO3YZAu7KOvG9zCno3fa1TVx0WjlvKJlqktDStrS8
         F0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780848292; x=1781453092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eK8MSldLeofL6fbYcJNtrJmeIPFDwpepphNpG1jidfI=;
        b=aJS2IHF4/Jr0xu1j4Kw0WPauP0btb8dcKXQY051EiZVOpcVhlns2jsYYp/lvE05Lw9
         /YNTx9hwhd81XiJRHwc9i79qvqen5VVNGiyXW0cxrzZsn3PQO8WuQM5mxiGlHqWCbXrf
         I5P7HZQoLjwnPj5MfCBs4JXgdgJ05W/qY2QdvMkvNQ9QzREshnzHvfys6acDwbUMs+Lb
         dRI5dEaDw7HheWbdMgRXwKiAZlvs7ja477z2QeVAQfLM6i4JHQU/rq7Q8TNJk0XKhXT5
         /uH2ZZtgVapoHJ7K8lsbzh19zk7d1PXrtqHvYTCCw6i4RzKpgYp8OflAN1TlQx9Q2PX+
         XZWw==
X-Forwarded-Encrypted: i=1; AFNElJ8/reG4t5iCSFYoybJm8j4WaP69nl+dRxPjafgLLvnq0KYy9G5ADcsVRxQe2NBmcf+yYjQa6BP5qkx+av2ktto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoN8nJ8fUo0EeqXNtMPu9rMNg4Gu5HSCr9YSNUs1nHhoHY1Eka
	E6XnPCMR28HysnpK29EpsFllvUxUbg9FMqIuk9D/MMazB8byAiyAvtXW
X-Gm-Gg: Acq92OGMOW5r3p6vvcSi5JZza7NmZL4GxovPbloy1dq3IHlxMckFjiq/J9rPhjo/hsN
	ZCsUJu3DzD53Ah6Lg4gQ+3KkOytuiPzBkZrgqWx0O+WJ5fng9Z/OgJnWJ0+HA2K2Kw20NTHoqQN
	BxaLkvIYPYe17BrLFENbf9pwVpP3p639Uuh/cwpjgtvuVMOCiWya2DlMMfxnnbbfqngk71YrgtI
	Gi9lVSva5n5qP3JIwfyxbsP70BMZe0q7a6hfV8vLCJRpevLQWo97V4cIg8G7rob9GgInEAjJbUp
	KbSVhmx4wxgkH+6c4UgZG6q3Ex5fCK+AQKSQagOY5uQyYtbcIvxgR641jO/929h6aUzS/PrbNxK
	m+n96jL2Wo8fmur/z8/MosO0ueEIqzjzxZwNLUf7GFA36vCg7ufW4vO0WD0mS8XjL4a6Ao6S1u7
	q4KydM0bVNVNtjoWQOUeRHN5n+jyNCidAyirhb3KkU6MaBdmgB3DfSSwMhFT1YZxne5plkIEQg4
	FBH9AMSSmaZaeLOqi83NHsimn90rrUzI509JmQU3qpp
X-Received: by 2002:a05:6000:2994:10b0:460:3233:f991 with SMTP id ffacd0b85a97d-4603233f9e2mr13227043f8f.40.1780848291905;
        Sun, 07 Jun 2026 09:04:51 -0700 (PDT)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcbe3sm41826482f8f.8.2026.06.07.09.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 09:04:51 -0700 (PDT)
Date: Sun, 7 Jun 2026 17:04:49 +0100
From: Vishal Moola <vishal.moola@gmail.com>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/mm/slab: document cache isolation with
 SLAB_NO_MERGE
Message-ID: <aiWWoUuQyADfIA7I@fedora>
References: <20260606155856.15548-1-med08elkadiri@gmail.com>
 <20260607070645.9559-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607070645.9559-1-med08elkadiri@gmail.com>

On Sun, Jun 07, 2026 at 08:06:45AM +0100, Mohammed EL Kadiri wrote:
> Add documentation to slab.rst explaining when and how to use
> SLAB_NO_MERGE to protect security-critical slab caches from
> cross-cache heap exploitation.

Thanks for helping improve the documentation. I haven't looked at the
patch, but have some comments in regards to the process.

We prefer to send new iterations of patches as separate threads,
with the exception being small fixes/cleanups.

Also, I'd recommend waiting a bit longer between versions to let the
maintainers comment since getting documentation is pretty particular.

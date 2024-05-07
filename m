Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373F14EC4D
	for <linux-hardening@vger.kernel.org>; Tue,  7 May 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075713; cv=none; b=PBJVzmdmiWzHD51pOclunxNdp0Vg5aEBfHuS2AETV+E6RKwtzrs4OK3cQlbsrHxKEuIlNNsBmhLtSsqqeAnmlQMSRZOOTSYew5WUIHcpIS8zy4jGd/0u+3d3O8d/lZtGnRkFh5YQaQriZcg2jXHsc+7pl5LAhKHI+VmPpqAn2b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075713; c=relaxed/simple;
	bh=ySzqAdBy3XIuOsN+4M43h3v/XUU1e6byy3HPdS66zkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1iX6MN+toc3NQjqwvKscOApn+n/JQAvJ5Q9SUjpO9GG1XCvh6KT6ashY1dyZ8drEh6nDjphA+XycEfdpvRHR7mBe7oEybvCkATquoNDdPlemGa2ALM3qDMsSm90KdElj6Ca/6Ibfdv0xdwojsS+R+QJegIrW7G7tCUhP5LCXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V0dSg1IF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V0dSg1IF"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34db9a38755so2732071f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 07 May 2024 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715075708; x=1715680508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhfsqJjab/igtBSwSRfO0D4527C8EIUuYcZOQelhvBc=;
        b=V0dSg1IFxe1jQLFl2gadot4iA8yd3gwclG6/dmeZr0pa7k1QonT/afNaxbtj/T6yE3
         F9C/uwty+h5F7YrQuOHKzclX+XKDHf8omtL8PFGzXyVUWwhOzUfO9aW9xeozf0P4U4pU
         QyYkYngC0x6FOwWLtImJJWejto4AHVIKin5dfB8EE1kLAPWYFkHs4JC/YYoh7aEQ4CAf
         AB9X+5AY1g2h1xqGSdN3QZ8pexdubdNPFxqYhmTtB4PQkmWuFEQ0e4nzSlJEpoq1U6ZV
         m/qDyaKEh+MA7/Hg9ce2QuqVWt7CT1ujyoAkRWh/xJ5FghGTXcaNRr86e65vA3D8bl/B
         wnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715075708; x=1715680508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhfsqJjab/igtBSwSRfO0D4527C8EIUuYcZOQelhvBc=;
        b=blRz+XgGRBR/hNA9BNM9hcyvXMg/AK09IBnIQQO7Ur83fQERodrnBmxSFEqoa2MUp+
         lAGw5CWT8alKW3X4wn4XkNdgnIYEeAV2zO/f+BaKOfeipnKiN6jLukAEF2Acu52Tt7mF
         DevtvivBj11reU+njypzka4FnLimzigDb5XB+wLwBvzzZyMeOdvEk8Wwa32qjGm4adXU
         T4pt2TVEYCbo9QYsftK3S4KC8H0EQ3qAuo55UvzuobGjO3fELIAA8E9vNqXi1ORVXM6j
         KG5jN9c7XyCMPD0Z0iu+SiXVtS4V64Ck+gVLm6p4UqRgdJLUnH1B5wxJWy7LOyZmyum7
         n/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVPN9ZWtnQ5uXxt0l/WHBhz49fkaMhoa++I0vPAaRaCzFf9iaeqZPJ9WTjYcDE5kDMyKoiJYrAdiA+UDY8hm9jW4n0zPAPAAgrUlvE1pCrn
X-Gm-Message-State: AOJu0Yzpj9XOo3cQKqONdDkCEa8Qix2/ydJE+bfvuoHWm+VULbxkQgdU
	I76DQwSF3eG44P/yJ4iQocjWP/Z81BZCZDGH0uISpI4tKBxvcq8gIVW/8KnI7iY=
X-Google-Smtp-Source: AGHT+IEnX+GiP1H1R7a/PVZu6gZKW9nIWDfc/aLhP5NK80VEMsnFZNqObUfhm9M51FbyUiTT3ER0zA==
X-Received: by 2002:a5d:4903:0:b0:34a:beb3:f6dc with SMTP id x3-20020a5d4903000000b0034abeb3f6dcmr12404727wrq.2.1715075708291;
        Tue, 07 May 2024 02:55:08 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b0041c5151dc1csm22844866wms.29.2024.05.07.02.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:55:08 -0700 (PDT)
Date: Tue, 7 May 2024 11:55:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: cleanup deprecated uses of strncpy/strcpy
Message-ID: <Zjn6ejJ9ecsuGsK2@pathway.suse.cz>
References: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>

On Mon 2024-04-29 23:06:54, Justin Stitt wrote:
> Cleanup some deprecated uses of strncpy() and strcpy() [1].
> 
> There doesn't seem to be any bugs with the current code but the
> readability of this code could benefit from a quick makeover while
> removing some deprecated stuff as a benefit.
> 
> The most interesting replacement made in this patch involves
> concatenating "ttyS" with a digit-led user-supplied string. Instead of
> doing two distinct string copies with carefully managed offsets and
> lengths, let's use the more robust and self-explanatory scnprintf().
> scnprintf will 1) respect the bounds of @buf, 2) null-terminate @buf, 3)
> do the concatenation. This allows us to drop the manual NUL-byte assignment.
> 
> Also, since isdigit() is used about a dozen lines after the open-coded
> version we'll replace it for uniformity's sake.
> 
> All the strcpy() --> strscpy() replacements are trivial as the source
> strings are literals and much smaller than the destination size. No
> behavioral change here.
> 
> Use the new 2-argument version of strscpy() introduced in Commit
> e6584c3964f2f ("string: Allow 2-argument strscpy()"). However, to make
> this work fully (since the size must be known at compile time), also
> update the extern-qualified declaration to have the proper size
> information.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [3]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

JFYI, the patch has been comitted into printk/linux.git, branch for-6.10.

I have removed the obsoleted brackets and added some empty lines
to break the blob of code a bit, see
https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=for-6.10&id=e0550222e03bae3fd629641e246ef7f47803d795

Best Regards,
Petr


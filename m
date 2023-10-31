Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8421DFE9
	for <linux-hardening@vger.kernel.org>; Tue, 31 Oct 2023 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i/jv3PeM"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA61E4
	for <linux-hardening@vger.kernel.org>; Tue, 31 Oct 2023 13:41:06 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SKhqf1r2lz9srX;
	Tue, 31 Oct 2023 21:41:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1698784862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hp84yni3w/m2CKBcr8zWmoOxEanjZqgFnmWK7QtuKS8=;
	b=i/jv3PeMhFyh7wm+fl1zxdbyeMI/XAkZIyzsMyEgro+TVMubumzpYEYj3aOKHR8y3EdVxL
	CFi2K331V7mvMDFi39iW2uAXCvNJ3VmGZZ7CP6LTJlGZ+aC1B/E0jVSpUwWt7mQXwwIzdp
	HQ34bOmD6dgypT24HGcc+DYmC+mRIAf2oVoqQ77bR+N78VaYf9q1X4RU1lrgHa898dC61R
	bf5bFPsHKaV1d69ATAbOgGmTcTrAI0WxA+ctPC6rQ4IvXTe28sv+wRZmz2ONIhWqEHf4gH
	9zTT5dUzs+e1JWB/pMIHX8JITq4BKjcmdFm5LwxSmfEqCDHGFaoPxiwhIw1Ktw==
Date: Tue, 31 Oct 2023 21:40:59 +0100
From: Stefan Bavendiek <stefan.bavendiek@mailbox.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: kernel-hardening@lists.openwall.com, linux-hardening@vger.kernel.org
Subject: Re: Isolating abstract sockets
Message-ID: <ZUFmW8DrxrhOhuVs@mailbox.org>
References: <Y59qBh9rRDgsIHaj@mailbox.org>
 <20231024134608.GC320399@mail.hallyn.com>
 <CAHC9VhRCJfBRu8172=5jF_gFhv2znQXTnGs_c_ae1G3rk_Dc-g@mail.gmail.com>
 <20231024141807.GB321218@mail.hallyn.com>
 <CAHC9VhQaotVPGzWFFzRCgw9mDDc2tu6kmGHioMBghj-ybbYx1Q@mail.gmail.com>
 <20231024160714.GA323539@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024160714.GA323539@mail.hallyn.com>
X-MBO-RS-META: udxo1pudytbk3n81hxb7scqspsm554uf
X-MBO-RS-ID: b50aa093106517e0fc2

On Tue, Oct 24, 2023 at 11:07:14AM -0500, Serge E. Hallyn wrote:
> In 2005, before namespaces were upstreamed, I posted the 'bsdjail' LSM,
> which briefly made it into the -mm kernel, but was eventually rejected as
> being an abuse of the LSM interface for OS level virtualization :)
> 
> It's not 100% clear to me whether Stefan only wants isolation, or
> wants something closer to virtualization.
> 
> Stefan, would an LSM allowing you to isolate certain processes from
> some abstract unix socket paths (or by label, whatever0 suffice for you?
>

My intention was to find a clean way to isolate abstract sockets in network
applications without adding dependencies like LSMs. However the entire approach
of using namespaces for this is something I have mostly abandoned. LSMs like
Apparmor and SELinux would work fine for process isolation when you can control
the target system, but for general deployment of sandboxed processes, I found it
to be significantly easier (and more effective) to build this into the
application itself by using a multi process approach with seccomp (Basically how
OpenSSH did it)

- Stefan

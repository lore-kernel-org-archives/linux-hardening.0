Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363262;
	b=yO3mHN8le3fN/sIMrSEQHX+YaXdvYRHSLn+VEtZIcz8V3KvGuMGFcy8H86kbkmcWFpJj
	 KfCM6r/kQZV0ll783cQja870ara9187h1yhXImsI2ujnJVBRXm4FhFKs9fPBIlIdlEKyE
	 S7JVNWp9ItuQtf5WLyu38hkxO9Wbh87I2Gh2G7pLouuD1wqwJPi+9/ldztuBKoybc/uPI
	 0waoEGhB26YDjEac3jh9mmgB4zRNy1DmC+U8XYvE62iE+Ay39pL/YPH7SKOLW+z7fPRG6
	 /uEPuwwSY4MRSP90EwXcUoe9PIjslN1ps+uM7io2tLM1QW8GK785CSsRSCGvif//6Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363262;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=l0w/1yDI89XOAGhQ/WS9dsByIozBKDOh521vH2pREDU=;
	b=XO87rpP/SG+4gUd8dTK9cIRn3fWNtgd7hiZVaqadzj7TFUzagNalmNgVT65yfXkh1o+l
	 Ngazg3IqzGKbbnMvdUpb1T2Uy0k2+6qqiFfjEhGDan3SmVPAiu/jxsQtZbWoSWTi6qOSM
	 ejmiaKojN3iS77K2cATGgjd32KphRCdh5yt5GNXd5pC3pF6oM/Q8yxJ/2jG1P9mT/ZF8t
	 Jwa43X+6nCB4f5AOeDUmfWQe8UmfFjAQE0eiJdfhMdgZX2P1pUbHEij53zcwRISfgLsGR
	 GR894oAh2rM8/GT5SZfe/+T7dYWFodXvhDwnrJoOudBPU+7WmubSLetTyvFQIDynIEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cmUHpVtO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E291606A320;
	Wed, 11 Nov 2026 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cmUHpVtO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E601F0089F;
	Wed, 11 Nov 2026 02:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794363257;
	bh=l0w/1yDI89XOAGhQ/WS9dsByIozBKDOh521vH2pREDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cmUHpVtOp+OnwJ7oyMYLYODcLFDyDJDba2Ov3IAWnIssdC9mOK2buxDZGOf8iUXHT
	 xiXMd2/kVzVPyflvgicdZAP4aLq5EzCoA3TsUegsOKy7i7v5v2txJfTN96LwCwTGZJ
	 Rm4FoWJefXp3lSwBP82MqvCSRheD1TPpsUM28y0s=
Date: Tue, 10 Nov 2026 21:14:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: CVE Assignment Team <cve@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] docs: cve: Describe how security fixes reach users
Message-ID: <2026111024-stilt-regalia-b637@gregkh>
References: <20261111014419.i.586-kees@kernel.org>
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
In-Reply-To: <20261111014419.i.586-kees@kernel.org>

On Tue, Nov 10, 2026 at 05:44:23PM -0800, Kees Cook wrote:
> Recent threads on kernel-hardening proposed new mechanisms for
> mitigating kernel CVEs while waiting for distributions to ship their
> fixes. The CVE documentation does not say how fixes reach users, or
> whose job it is to get them into a vendor's kernel. Add a section that
> does, summarizing the answers given in those threads.
> 
> Link: https://lore.kernel.org/all/2026110719-zipping-silliness-2443@gregkh/
> Link: https://lore.kernel.org/all/2026111052-spectator-legwarmer-4c1e@gregkh/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  Documentation/process/cve.rst | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/process/cve.rst b/Documentation/process/cve.rst
> index 5e2753eff729..d16b5c2bf7ba 100644
> --- a/Documentation/process/cve.rst
> +++ b/Documentation/process/cve.rst
> @@ -119,3 +119,33 @@ assigned to all fixes for all issues, but sometimes we will fail to
>  notice fixes, therefore assume that some changes without a CVE assigned
>  might be relevant to take.
>  
> +Getting security fixes
> +======================
> +
> +Fixes for security issues reach users the same way as every other
> +fix: through the stable and longterm kernel releases listed at
> +https://kernel.org/releases.html.  These are released frequently, each
> +one tested as a whole by many community members.  The CVE assignment team
> +announces these fixes on the linux-cve-announce mailing list,
> +and only once a fix is in a stable kernel tree, so the fix is already
> +available when its CVE is announced, and no vendor learns of a CVE before
> +anyone else (except for the very rare case of :ref:`embargoed flaws
> +<process/security-bugs:Disclosure and embargoed information>`,
> +which do not include :ref:`AI-discovered flaws
> +<process/security-bugs:What qualifies as a security bug>`).
> +All of this is available to everyone, at no cost.
> +
> +The best response to a CVE, and the quickest way to receive its fix, is
> +to run one of those kernels and keep updating it.  A kernel version
> +that is no longer supported there only gets a fix after someone
> +backports it, and that work is done outside the kernel community.
> +
> +If your kernel comes from a Linux distribution or another vendor,
> +getting fixes into it is that vendor's responsibility.  The kernel
> +developers and stable maintainers publish the fixes, but they do not
> +integrate them into each vendor's kernel.  If fixes reach you later
> +than you need them, raise it with your vendor, particularly if you pay
> +them for support, since keeping your kernel up to date and secure is
> +part of what that support provides.  If your vendor cannot keep up,
> +some distributions follow the stable releases closely and ship their
> +fixes promptly, also at no cost.
> -- 
> 2.55.0
> 

Thanks for documenting this.  Hopefully the companies that don't keep up
to date kernels will get the proper pushback from their customers to fix
their release processes...

greg k-h

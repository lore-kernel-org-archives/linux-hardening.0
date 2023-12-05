Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="i/PNNhz0"
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE77194;
	Tue,  5 Dec 2023 14:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701816092;
	bh=RADxu9DladnQuPEEYoqwAwtdXSXRn/xTNYBYSRG5xo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/PNNhz098jJeinwKz9W78Z/IkTsMAJx5V+pSEhr4QKMjximz0mHEI++EZLdFLO4J
	 vDluKmBkcgJaQR9esCp68WX7p23oBKby429p1/qDixTqPQ5ZCEtoy0jyLA5Qpdngtt
	 rRVvBy2a7wrG3xl6a2k3X3JLJxw0hCZ7TyFYl7js=
Date: Tue, 5 Dec 2023 23:41:32 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Granados <j.granados@samsung.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
Message-ID: <4a93cdb4-031c-4f77-8697-ce7fb42afa4a@t-8ch.de>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net>
 <ZW+lQqOSYFfeh8z2@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZW+lQqOSYFfeh8z2@bombadil.infradead.org>

On 2023-12-05 14:33:38-0800, Luis Chamberlain wrote:
> On Mon, Dec 04, 2023 at 08:52:26AM +0100, Thomas Weißschuh wrote:
> > @@ -231,7 +231,8 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
> >  		return -EROFS;
> >  
> >  	/* Am I creating a permanently empty directory? */
> > -	if (sysctl_is_perm_empty_ctl_header(header)) {
> > +	if (header->ctl_table == sysctl_mount_point ||
> > +	    sysctl_is_perm_empty_ctl_header(header)) {
> >  		if (!RB_EMPTY_ROOT(&dir->root))
> >  			return -EINVAL;
> >  		sysctl_set_perm_empty_ctl_header(dir_h);
> 
> While you're at it.

This hunk is completely gone in v3/the code that you merged.

> This just made me cringe, and curious if some other changes
> could be done to make this obviously clear during patch review
> that this is safe.

Which kind of unsafety do you envision here?

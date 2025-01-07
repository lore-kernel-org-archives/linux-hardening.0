Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1CA16DEB1;
	Tue,  7 Jan 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268772; cv=none; b=kihCSt3VqhSPdFVKTEwSyKV6qfJbl7U+efw7SdS0wzyG2vxTMzAp9YKTmALIATpwg4b9Yx4eQ9IO3MF3Yxm58GttSR85E1wyZl0CKAixL78FaVr0GFG+jCnXAUNjYBIX3aD3kCaZGdg5hvFBz7oKwaVOVcYHN1WsbXOO21DJ6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268772; c=relaxed/simple;
	bh=nv9rXqNH1ImGnwbxoWC5PKtFGL7Cr7HNH6PmRTRReAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+GBerV09ZY/8m5H2QxSxYpW0lHAREXInki/HXRUJPQz2GjQX4QaQD/7asJbBHmw0yxoMW6lhXllUqqdYS3fyxwZwzOD3Qumx2d4jEnofFOjZzHuUZNkRPICkNy0oURX5kF4Jpc88VZLCbzqbv4GISxmHzJ7Ge01IgFmRyGc9sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BB1C4CED6;
	Tue,  7 Jan 2025 16:52:51 +0000 (UTC)
Date: Tue, 7 Jan 2025 17:52:49 +0100
From: Greg KH <greg@kroah.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/6] module: sysfs: Cleanups and preparation for const
 struct bin_attribute
Message-ID: <2025010737-dwelling-pacific-f74f@gregkh>
References: <20241227-sysfs-const-bin_attr-module-v2-0-e267275f0f37@weissschuh.net>
 <6f2d2843-e676-4d4a-86aa-881378b1adf1@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f2d2843-e676-4d4a-86aa-881378b1adf1@suse.com>

On Tue, Dec 31, 2024 at 04:07:40PM +0100, Petr Pavlu wrote:
> On 12/27/24 14:23, Thomas Weiﬂschuh wrote:
> > The sysfs core is switching to 'const struct bin_attribute's.
> > Prepare for that.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > ---
> > Changes in v2:
> > - Avoid NULL-deref in free_sect_attrs()
> > - Avoid double-free and NULL-deref in free_notes_attrs()
> > - Also drop 'struct module_sect_attr'
> > - Link to v1: https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-module-v1-0-f81e49e54ce4@weissschuh.net
> > 
> > ---
> > Thomas Weiﬂschuh (6):
> >       module: sysfs: Drop member 'module_sect_attrs::nsections'
> >       module: sysfs: Drop member 'module_sect_attr::address'
> >       module: sysfs: Drop 'struct module_sect_attr'
> >       module: sysfs: Simplify section attribute allocation
> >       module: sysfs: Add notes attributes through attribute_group
> >       module: sysfs: Use const 'struct bin_attribute'
> > 
> >  kernel/module/sysfs.c | 116 ++++++++++++++++++++++++--------------------------
> >  1 file changed, 55 insertions(+), 61 deletions(-)
> > ---
> > base-commit: d6ef8b40d075c425f548002d2f35ae3f06e9cf96
> > change-id: 20241215-sysfs-const-bin_attr-module-be05346937a6
> 
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> I'm going to wait for a few days if others want to comment and then plan
> to queue this on the modules tree for the 6.14 merge window.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

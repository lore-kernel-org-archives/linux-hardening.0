Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Z1FoUWKO"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C97BE8;
	Sat,  2 Dec 2023 13:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4Rwyik1Cyaf8rPAzDwFjNdQAfgF5Q1clOrCxMqMQ94o=; b=Z1FoUWKOMFkaUPPOx1TpIBqZYj
	oE/rw6p6G0Gdbrxv1xh+gWe62MwcSRjvo66FsO/w+Y0rbVbvivKZ8F5dlKiE11g9E3j9mwDfoz7zN
	HJgQyvOwilDkm4U5MxnnAmc5fKMpI4fhp8h4CtxvxtIV2fS0eB1FAIPvTc2a9UxQlLNFSQCGXFTja
	4xSL1DjiYZLcOIC8lBMtb0KacxdxNt7dPRvugTbkKLVicFsWzGTo62N+PcjFPWkRpeGw3P4kaBNz6
	prVtjHDOySrh1PSdPhho5ImtrQ6w0uwx5Wa2fkn1LVb8lXYTJfDoSZYn5ls50lnnw5fpdRlyihuBw
	LnFtuiOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r9XnK-006OGD-15;
	Sat, 02 Dec 2023 21:45:02 +0000
Date: Sat, 2 Dec 2023 21:45:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kees Cook <keescook@chromium.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: Add DEFINE_FREE for struct inode
Message-ID: <20231202214502.GS38156@ZenIV>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-3-keescook@chromium.org>
 <20231202212846.GQ38156@ZenIV>
 <202312021331.D2DFBF153@keescook>
 <20231202214212.GR38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202214212.GR38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Dec 02, 2023 at 09:42:12PM +0000, Al Viro wrote:

> I'll poke around and see what I can suggest; said that, one thing I have
> spotted there on the quick look is that you are exposing hashed dentry associated
> with your inode before you set its ->i_private.

... and on the second look, no, you do not do anything of that sort.
My apologies...

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E32137C
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 13:28:07 +0000 (UTC)
Received: from out-200.mta0.migadu.com (out-200.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4814C4
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 06:28:04 -0700 (PDT)
Date: Tue, 3 Oct 2023 09:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696339682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2y99uhSU3WpoFMIg+wbc3gCYqBiPyHro0o55Qa3UnWc=;
	b=AGYVpbXcGCWBKTwBX6dVtk5jwQVc4w+bmO3nbwnqS5aKI6VdKmUDmhJffxANSDC8JRpOIa
	FeAtQ0l1yVeZ1+m1RR3eRXolCm4e1TB9O7wt4dtX1SWi3ygtpHUTRCaAsUFUIyUuVPqwAs
	4W7riUzi5AL99wgmWwln7fUBJIKjjmc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brian Foster <bfoster@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 df964ce9ef9fea10cf131bf6bad8658fde7956f6
Message-ID: <20231003132758.uioastp5lxnitwxz@moria.home.lan>
References: <202309301308.d22sJdaF-lkp@intel.com>
 <202309301403.82201B0A@keescook>
 <20231002032239.t7ghpigbq5jy3ng7@moria.home.lan>
 <202310012150.72AAB06FAD@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310012150.72AAB06FAD@keescook>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 01, 2023 at 09:52:22PM -0700, Kees Cook wrote:
> On Sun, Oct 01, 2023 at 11:22:39PM -0400, Kent Overstreet wrote:
> > I'm not leaping at the chance to reorganize my fundamental data
> > structures for this.
> 
> Yeah, understood. Thanks for taking a look at it!
> 
> > Can we get such an escape hatch?
> 
> Sure, please use unsafe_memcpy(), and include a comment on how the sizing
> has been bounds checked, etc.

Thanks, I knew there had to be one :)

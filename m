Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997568;
	b=qs0XtLkGD5RkxjIP8BAx680NKzcWRsAONT2JiJpy7vj2RRDN07Q9cAQYA3tEa/nQGb7w
	 nC+keii0y/LikbQxyJmXKsSEYbgZVug0ZAa1tPkk4rFepUq88n26cBN5Vn8IrgtO+mSVF
	 ciSKIufKB80mww4axmQ3JvEcV5UM/gSPfdKuO1M6kUG58rC3m0+A0OxfFKXeQBhsZ086w
	 4NUi2/bC6vm9KIPEW7g3gfMIozOW0mWrbkrQc2PYep9MqAki2IzIAzV75Kcj3ObgiS6Nd
	 5pECcmbtfT0t1x8eRVbOXQ3Y5kxgXdzJwyJ3FSONHh7v/d2q7m9LizOvN4ir0qrSCBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997568;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y0BVziaquUjVVAPoh4llDs6v2FQ9OhndML7IsF84gsc=;
	b=Sjmszfp5QQk3FBox4e21ByPSOwr2aUD4FfWhzkGc8V5DZB9XgGD/yH2vzNh3eMPoOavq
	 /PbqjivGYj6cMkXRfgaqx0NmiwE7cCaw3y/Yqd60Ri2VwqPKDaZHbwJ12tWn8RJ8NipQ3
	 IDKAIgwNPgxJfDkcK4sIXZFeB/bWQJwGq61CrY9ihpINZDd2k2P3FVYFk51xhV9BFT+yV
	 9lQTphW2iy0dZUjtZ14Z5y24Pc1kXwF8Hrs6wBnUJdjCXRZWwTPThRO1MrVmg+gQHFX3o
	 oZZc4xataAKHVMaXBN/Yogg6C1WXWYcM17b35YxkeTXj+musij/GeXJq/+pzueNJl3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=QFns8ebX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jnaNMHw6;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F2606A338
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 20:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 969F2606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=QFns8ebX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jnaNMHw6
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F2FAEC01E2
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 15:39:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 06 Nov 2026 15:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793997564;
	 x=1794083964; bh=y0BVziaquUjVVAPoh4llDs6v2FQ9OhndML7IsF84gsc=; b=
	QFns8ebXFo0UFvT6+ZHPsjuq+ghcluonVEII3xNwxed3tzNZSMo0BDnZS3wq9lKo
	0t5PE6BPBfCVD/nTpgG5nwaqP6/OX3R5qJ6KDfKf1RgOt86qNBb+s7sM0+uWuMIZ
	H1+IEctvDJOBnF2LcVuu1jVTd2xWcB61EbuTFQIQIY6cKRq611Yhpo1ZXcNt2Xis
	2v3z+2PCZgSpn0JazvwAKLS6Iw3/OgxnSfXbPL6M5J2U2zc2E3qYoNejg1j7oTJo
	Yui5sKMjD7NzhcqC60CUNh3OL5V5TQjQ1hySMnCfJlm8QSwulyGCXh8F9s2KAaGF
	Ghwbe1SB3VWQSdmDM4MrIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793997564; x=
	1794083964; bh=y0BVziaquUjVVAPoh4llDs6v2FQ9OhndML7IsF84gsc=; b=j
	naNMHw6TOkiuBhQIxtaTCEmuvzmoa6wH6SL5N5kjy38vB1ucE+V8i3AQd0q9rb+h
	dldrUfO0DPZZ7Xxim5fi08xJdLrHF71dihHNdTahXafS5oWt/OIW2/CRNjJyR2Th
	Ceg0bMTZN1v2YKd3FqFuqnqqlF9W6ZQzYhUtp1OXeqCOD6tO6r207r/Pyp9eCoUi
	Uw55yiI876gdEhjtzdmyFfHYJsoi75/Puatt0AasECt38B/r3sLUaKb69pATEuwf
	CHPVG9LA3cl1um+RnAOjwiWRYFvutWcLPZc6M1LqemJvgeeZDdEVSBXXLQ7IQNtS
	GZ5G+BAFYDz01NzSmuuAQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793997564; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LWhhcmRlbmluZ0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Wjw+DdmCSfo/Vc82O3OJifG7xkeKiH0kxnRL0vmrG1wPpp1
	urcCQ/YnkSphi9++PpzEE5lsRiayzxnlohDRkOVrmRUmqtz6+5rgfpR7GGSTSBad
	CXCj7csGJA7j3U3/G21b+4PrO2ibPSGvRHG9sLehXOsD62e3ZRBUeQeK/7ufe7X9
	gpH1tFT6SI9Hg8PChk4IJBeKQ6eWeYam+nelSVvdYDAxHJPVKSTLZX9XLg5rJttn
	NC/BmnFX9cC/mCMDqMJiF2NsaoR4tdMioa9DUgKYwlcWEqYW9OYVcQ4Gg0hKAGiL
	W1qEoMvpMX9pY+fJbUGlhyj/3Ap3bUQ4aD9ffuA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:TC2OAASFXc/kqGL+CunvWFfjUQDUXEFfcgl8mkejbCw=:KLM1XTdGORKLzVXxMM2+MBqBSSgPSj1LNFXBZwNORQc=;
X-ME-Sender: <xms:-zruapswx845re28jK7E-OISiOWhgLdGEzbA0gYJ4Jaukh4q8ERM5w>
    <xme:-zruagGv_oYl0JasYwTqNuMV9YfG4cqnE57Xk0ZmwUhwx4wfvWkkZcKjTNiOcHNH5
    f1ObK33XWf7tyXP_cUBksnGPcFiyply7mFddvMfjxbMyfhNaK9-Rg>
X-ME-Received: <xmr:-zruakL7z03VZTgAiqT4Blwr0mVgipsBhSTSBlaAlE-iTpTJR0DAEzose6zAjw>
X-ME-Proxy-Cause: dmFkZTGIbL7eiEY7X8p/l+CeUB7m44a61PuMeL+fbY3aREjzPUsLlzqVekELJvtGSYzY/I
    nO/9fOkHagfaTDpr/q7Hu4ec1OgxpJzeR1b+u+/9ylFLL0hiPQ7Q5WGOti0WTlU639UET8
    W0OANyCth0cdOR2e7W6mWO1PJHdl/BResgCHiTxzvLlqq3zCDX3wvzLg16WhpWjXSqlvxH
    89LRMj0xWkNEZ4qN6TB296bhwMUVIMYXaAmu9mgVoI4iM8H8vundo/2ymieM+LgoFiwTPq
    IhQxBsWs0Ga7dr1x8oM6/9wnzhBZVCQvByhcFz33jTVizQNgL5tYw3VmrPQxyPhLIvxifv
    H7QY9kPySOCsFJrhxoC6uqsSDc1GcMOACH3r7Wrmfr/jnoMJGP58FMF4t2RcELJnfT33jD
    je5SutMzSelw6oN50vcX7lIELIN9R0dR9ohFPMT4pfg+q7rmzgKEPWOhidL3uG4rHDfx8E
    bdsoBTFLWpPoCvbhqBhLI+776dylwZRjCQk6W/hoGKw0YgFB8jgrcJoIK9CA/qxfCdKgtu
    VpseP5mr6Y0vLjZMqZAROvOolYbNFuQE9hVhhbAwSnSVTI/Gge+4z1RvnWcKgImEeF39T+
    OWgDl/6GYLI6UCeWNQ2UCfPZamPvO1USkUaKy4natYDrfR6Un0JmtJhr1VyA
X-ME-Proxy: <xmx:-zruaoYTS6zaXrUnuamRBu1QXRKhqDl6CLVkSZ2bn8QMmD4Yem2QHw>
    <xmx:-zruahps8Qx_fewfGVvHRM6AEFA-RYq-3pHwGw9P3jodAEu4HSumLg>
    <xmx:-zruagHkcYHQpi7Qlk7TjgwSxyJUT48sIqyc-BBi0duFKzQbget_zg>
    <xmx:-zrualdFIYqEPdPn5BJgS0ePxXMEsDJW9LK7HWSjS1lZq1TJQzK-pA>
    <xmx:_DruatZac4csxBguHlwKZ6baZZokuGozy6Fj434FxEBTDO-Hb4g6MpQ1>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 15:39:21 -0500 (EST)
Date: Fri, 6 Nov 2026 13:39:20 -0700
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v6 09/31] vfio/pci: Advertise the mmap areas around
 excluded ranges
Message-ID: <20261106133920.144f0665@shazbot.org>
In-Reply-To: <20261016161839.2765592-10-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-10-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 21:48:16 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A range excluded from mmap must not be reachable through an mmap of its
> BAR. Refuse an mmap that overlaps such a range, and advertise the BAR
> with a sparse mmap capability that lists the areas between the excluded
> ranges, so a VMM maps those and traps the rest.
> 
> mmap is page granular, so each range is rounded out to whole pages, and
> ranges that meet after rounding form one hole. The sorted list gives the
> areas in two walks: the first counts them and the second fills them.
> 
> A BAR without mmap-excluded ranges gets no new capability. The MSI-X
> table is excluded from read and write only, so the MSI-X BAR is
> unchanged.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 91 ++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index bee3d1b4d8d2..f099a294af34 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1106,6 +1106,88 @@ static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev)
>  	}
>  }
>  
> +/* True when [start, start + len) on @bar overlaps a range with any of @flags. */
> +static bool vfio_pci_bar_range_excluded(struct vfio_pci_core_device *vdev,
> +					int bar, u64 start, u64 len, u32 flags)
> +{
> +	struct vfio_pci_excluded_range *range;
> +
> +	/* Only BARs have excluded ranges; a device-specific region has none. */
> +	if (bar >= PCI_STD_NUM_BARS)
> +		return false;
> +
> +	list_for_each_entry(range, &vdev->excluded_ranges[bar], entry) {
> +		if (range->start >= start + len)
> +			break;
> +		if ((range->flags & flags) &&
> +		    start < range->start + range->size)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * Advertise a BAR with mmap-excluded ranges as the mmap-able areas between
> + * them. mmap is page granular, so each range is rounded out to whole pages;
> + * ranges that meet after rounding merge into one hole. The first walk counts
> + * the areas and the second fills them.
> + */
> +static int vfio_pci_excluded_sparse_cap(struct vfio_pci_core_device *vdev,
> +					int bar, struct vfio_info_cap *caps)
> +{
> +	struct vfio_region_info_cap_sparse_mmap *sparse __free(kfree) = NULL;
> +	u64 bar_len = pci_resource_len(vdev->pdev, bar);
> +	struct vfio_pci_excluded_range *range;
> +	u32 nr_areas = 0;
> +	bool holes = false;
> +	u64 pos = 0;
> +	u32 i = 0;
> +
> +	list_for_each_entry(range, &vdev->excluded_ranges[bar], entry) {
> +		if (!(range->flags & VFIO_PCI_EXCLUDE_MMAP))
> +			continue;
> +		holes = true;
> +		if (ALIGN_DOWN(range->start, PAGE_SIZE) > pos)
> +			nr_areas++;
> +		pos = max(pos, ALIGN(range->start + range->size, PAGE_SIZE));
> +	}
> +	if (!holes)
> +		return 0;
> +	if (pos < bar_len)
> +		nr_areas++;

The number of sparse ranges is bounded by (num_mmap_excluded_ranges +
1).  We're dealing with a very low number of excluded ranges, bounded by
insertion via kernel drivers and core.  It seems worthwhile to avoid
the duplication with a simple list walk that counts the mmap excluded
ranges, then all of the alignment happens once, and the resulting
nr_areas is calculated as we fill.

Note that with the use of __free, it's generally recommended to
allocate at the point it's declared and mixed declarations and
statements are allowed for this.  We can therefore do the declaration
and allocation after we've done the simple version of the counting loop.
Thanks,

Alex

> +
> +	sparse = kzalloc_flex(*sparse, areas, nr_areas);
> +	if (!sparse)
> +		return -ENOMEM;
> +
> +	sparse->header.id = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
> +	sparse->header.version = 1;
> +	sparse->nr_areas = nr_areas;
> +
> +	pos = 0;
> +	list_for_each_entry(range, &vdev->excluded_ranges[bar], entry) {
> +		u64 hole = ALIGN_DOWN(range->start, PAGE_SIZE);
> +
> +		if (!(range->flags & VFIO_PCI_EXCLUDE_MMAP))
> +			continue;
> +		if (hole > pos)
> +			sparse->areas[i++] = (struct vfio_region_sparse_mmap_area) {
> +				.offset = pos,
> +				.size = hole - pos,
> +			};
> +		pos = max(pos, ALIGN(range->start + range->size, PAGE_SIZE));
> +	}
> +	if (pos < bar_len)
> +		sparse->areas[i] = (struct vfio_region_sparse_mmap_area) {
> +			.offset = pos,
> +			.size = bar_len - pos,
> +		};
> +
> +	return vfio_info_add_capability(caps, &sparse->header,
> +					struct_size(sparse, areas, nr_areas));
> +}
> +
>  int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
>  				      unsigned int type, unsigned int subtype,
>  				      const struct vfio_pci_regops *ops,
> @@ -1254,6 +1336,10 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
>  				if (ret)
>  					return ret;
>  			}
> +			ret = vfio_pci_excluded_sparse_cap(vdev, info->index,
> +							   caps);
> +			if (ret)
> +				return ret;
>  		}
>  
>  		break;
> @@ -1947,6 +2033,11 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>  	if (req_start + req_len > phys_len)
>  		return -EINVAL;
>  
> +	/* An excluded sub-range is reachable only through its trap, not mmap. */
> +	if (vfio_pci_bar_range_excluded(vdev, index, req_start, req_len,
> +					VFIO_PCI_EXCLUDE_MMAP))
> +		return -EINVAL;
> +
>  	/*
>  	 * Ensure the BAR resource region is reserved for use.
>  	 */


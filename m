Return-Path: <SRS0=C0P2=DI=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA9AC4727E
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Oct 2020 18:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3ABF20848
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Oct 2020 18:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="YwGVOL3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgJASAv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Oct 2020 14:00:51 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:43442 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730029AbgJASAv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Oct 2020 14:00:51 -0400
X-Greylist: delayed 1043 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2020 14:00:50 EDT
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091Hc9Rm030058;
        Thu, 1 Oct 2020 17:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=e7ckkIBcOrgjqpyeS2eBHq7YI5a3szzWNQprkLz6E3E=;
 b=YwGVOL3ccXssQDMy3bAQFsyujy74pE0+0uVh+pNNMsAXQr2oQ1FbUefqQ1EpiG/Uyrz9
 sdHYP23UtHJx+oDhZwzZcA4KXXqPijITthmpKgU+hseqwRlSvVtMysxIskq+q2i5RHxO
 LUoP3Xdd2T8FVqp/Jz4WOPxrlbHS2KxjTl6b2ibK2pTGLiRym5FnP3DlPzb9u5MMBVm8
 KGsXaTHnTXaMlP3uWAyy+1qfS3a3TdcLe79IwaY7tPedDNMN2va26OwYUe9yW39wjUMm
 hRnFV4jBgm8Xfii205Y0zTgN8vRNzQC5Akgx8OzKdRBv1G6Z7s3ypr1sB4dZgKt5bBYX gw== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 33wbdvcktb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 17:43:00 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id B84EC7C;
        Thu,  1 Oct 2020 17:42:58 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.129.62])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 27B8948;
        Thu,  1 Oct 2020 17:42:57 +0000 (UTC)
Date:   Thu, 1 Oct 2020 12:42:56 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] x86/uv/time: Replace one-element array and save
 heap space
Message-ID: <20201001174256.GV739899@swahl-home.5wahls.com>
References: <20201001145608.GA10204@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201001145608.GA10204@embeddedor>
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_06:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010148
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 01, 2020 at 09:56:08AM -0500, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use “flexible array members”[1] for these cases. The older
> style of one-element or zero-length arrays should no longer be used[2].

I see this has already gone in, so I'm late.  But for whatever it's
worth, it's a good change.  Thank you.

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

--> Steve wahl

> struct uv_rtc_timer_head contains a one-element array cpu[1].
> 
> Switch it to a flexible array and use the struct_size() helper to
> calculate the allocation size. Also, save some heap space in the
> process[3].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays
> [3] https://lore.kernel.org/lkml/20200518190114.GA7757@embeddedor/
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Build-tested-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/5f75bc0a.rQcNS6620b2eA74S%25lkp@intel.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Modify changelog text (Thomas).
>  - Add Reviewed-by and Build-tested-by tags.
>  - Add a public link to the build-test results.
> 
>  arch/x86/platform/uv/uv_time.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
> index f82a1337a608..6c348c2d0def 100644
> --- a/arch/x86/platform/uv/uv_time.c
> +++ b/arch/x86/platform/uv/uv_time.c
> @@ -52,7 +52,7 @@ struct uv_rtc_timer_head {
>  	struct {
>  		int	lcpu;		/* systemwide logical cpu number */
>  		u64	expires;	/* next timer expiration for this cpu */
> -	} cpu[1];
> +	} cpu[];
>  };
>  
>  /*
> @@ -148,9 +148,8 @@ static __init int uv_rtc_allocate_timers(void)
>  		struct uv_rtc_timer_head *head = blade_info[bid];
>  
>  		if (!head) {
> -			head = kmalloc_node(sizeof(struct uv_rtc_timer_head) +
> -				(uv_blade_nr_possible_cpus(bid) *
> -					2 * sizeof(u64)),
> +			head = kmalloc_node(struct_size(head, cpu,
> +				uv_blade_nr_possible_cpus(bid)),
>  				GFP_KERNEL, nid);
>  			if (!head) {
>  				uv_rtc_deallocate_timers();
> -- 
> 2.27.0
> 

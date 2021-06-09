Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB298C48BCD
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Jun 2021 21:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 867EF613F3
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Jun 2021 21:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFIVsW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Jun 2021 17:48:22 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:41870 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhFIVsO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Jun 2021 17:48:14 -0400
Received: by mail-pf1-f178.google.com with SMTP id x73so19676048pfc.8
        for <linux-hardening@vger.kernel.org>; Wed, 09 Jun 2021 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0XYECOmxsaMaLxHoLYjfZFxvSSA4dD3DlKRpuLiD3Rc=;
        b=FLW/EUXTlbxIh5ve0hPEM3cR8gRMru632OvcVzVD3vVjnoBoUyK6+CN5uWDX/GomMJ
         vsOcjyZDLFoiIBS20uZ/kXm1v3WUlnkbX8GstRxE63WRtisYJIOPktqwR3fELZpKtzaT
         zqz6nUoNgy36/DM/jmzG/ZTFhUeIgXTKVWC7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0XYECOmxsaMaLxHoLYjfZFxvSSA4dD3DlKRpuLiD3Rc=;
        b=XLTSXryS9XiMuU8hyYlxH7X9WgKRQc4ju8XVWNbevTKRpclRR+cyDpgcHaWk86dBDh
         b0WLZI56gkxvb11Svgd4iajQWUyCjVf48UBWEIjfOg32UsuJDf2+n35GS/iyrLlW64Fh
         FRFAowQfInBbwti9kri2TVcB6TbCDdDJd42rF2waC4C5nszDqQiW2x7JqmRBZvbxoY63
         MWfJKdPSZlBbfdoGZi9fqoUK4rsNCa5aPJeTUF24fpeN8BFYYfWiXy/G9LOoP4lGo0ix
         HXXJuET+2EnrhuErMhMfCg8W8wvBhDqF5SaUHMpCK1HczA/hBhswJkaUdN+PXFm9uL4F
         oFfg==
X-Gm-Message-State: AOAM530NxBBWKCZjooKDHjlngq8w+gIy5++r+7OS2KkXtH8sdb4BnDjY
        pQsOs6nhS/Wv3D01qn8VSZ54TIiU6PSXIA==
X-Google-Smtp-Source: ABdhPJxe8pzlj9Q+9OJdkrUg+zpE0g3dvGmj9lZQktflzXAZ/16KG8tQMYC7EHu9xnz9XJw/u4n4Ew==
X-Received: by 2002:a63:3fc6:: with SMTP id m189mr1680188pga.239.1623275109063;
        Wed, 09 Jun 2021 14:45:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17sm611807pgm.37.2021.06.09.14.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 14:45:08 -0700 (PDT)
Date:   Wed, 9 Jun 2021 14:45:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH][next] virtchnl: Replace one-element
 array in struct virtchnl_vsi_queue_config_info
Message-ID: <202106091424.37E833794@keescook>
References: <20210525231658.GA176466@embeddedor>
 <f3674339c0390ced22b365101f2d3e3a2bf26845.camel@intel.com>
 <85e62583-5db9-ac5c-fdf9-8e3f6a50f3fa@embeddedor.com>
 <7273a541a4864fcfb1a7ba2e105885d3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7273a541a4864fcfb1a7ba2e105885d3@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, May 29, 2021 at 12:19:48AM +0000, Keller, Jacob E wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> > Gustavo A. R. Silva
> > Sent: Friday, May 28, 2021 4:05 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Brandeburg, Jesse
> > <jesse.brandeburg@intel.com>; gustavoars@kernel.org
> > Cc: intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org; linux-
> > hardening@vger.kernel.org
> > Subject: Re: [Intel-wired-lan] [PATCH][next] virtchnl: Replace one-element array
> > in struct virtchnl_vsi_queue_config_info
> > 
> > 
> > 
> > On 5/28/21 16:56, Nguyen, Anthony L wrote:
> > > On Tue, 2021-05-25 at 18:16 -0500, Gustavo A. R. Silva wrote:
> > >> There is a regular need in the kernel to provide a way to declare
> > >> having a
> > >> dynamically sized set of trailing elements in a structure. Kernel
> > >> code
> > >> should always use “flexible array members”[1] for these cases. The
> > >> older
> > >> style of one-element or zero-length arrays should no longer be
> > >> used[2].
> > >>
> > >> Refactor the code according to the use of a flexible-array member in
> > >> struct
> > >> virtchnl_vsi_queue_config_info instead of one-element array, and use
> > >> the
> > >> flex_array_size() helper.
> > >>
> > >> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> > >> [2]
> > >> https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-
> > length-and-one-element-arrays
> > >>
> > >> Link: https://github.com/KSPP/linux/issues/79
> > >> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > >> ---
> > >>  include/linux/avf/virtchnl.h | 9 ++++-----
> > >>  1 file changed, 4 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/include/linux/avf/virtchnl.h
> > >> b/include/linux/avf/virtchnl.h
> > >> index b554913804bd..ed9c4998f8ac 100644
> > >> --- a/include/linux/avf/virtchnl.h
> > >> +++ b/include/linux/avf/virtchnl.h
> > >> @@ -338,10 +338,10 @@ struct virtchnl_vsi_queue_config_info {
> > >>  	u16 vsi_id;
> > >>  	u16 num_queue_pairs;
> > >>  	u32 pad;
> > >> -	struct virtchnl_queue_pair_info qpair[1];
> > >> +	struct virtchnl_queue_pair_info qpair[];
> > >>  };
> > >>
> > >> -VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_vsi_queue_config_info);
> > >> +VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_vsi_queue_config_info);
> > >>
> > >>  /* VIRTCHNL_OP_REQUEST_QUEUES
> > >>   * VF sends this message to request the PF to allocate additional
> > >> queues to
> > >> @@ -997,9 +997,8 @@ virtchnl_vc_validate_vf_msg(struct
> > >> virtchnl_version_info *ver, u32 v_opcode,
> > >>  		if (msglen >= valid_len) {
> > >>  			struct virtchnl_vsi_queue_config_info *vqc =
> > >>  			    (struct virtchnl_vsi_queue_config_info
> > >> *)msg;
> > >> -			valid_len += (vqc->num_queue_pairs *
> > >> -				      sizeof(struct
> > >> -					     virtchnl_queue_pair_info))
> > >> ;
> > >> +			valid_len += flex_array_size(vqc, qpair,
> > >> +						     vqc-
> > >>> num_queue_pairs);
> > >
> > > The virtchnl file acts as a binary interface between physical and
> > > virtual functions. There's no guaruntee that the PF and VF will both
> > > have the newest version. Thus changing this will break compatibility.
> > > Specifically, the way the size was validated for this op code
> > > incorrectly expects an extra queue pair structure. Some other
> > > structures have similar length calculation flaws. We agree that fixing
> > > this is important, but the fix needs to account that old drivers will
> > > send an off by 1 size.
> > >
> > > To properly handle compatibility we need to introduce a feature flag to
> > > indicate the new behavior. If the feature flag is not set, we acccept
> > > messages with the old format (with the extra size). If both the PF and
> > > VF support the feature flag, we'll use the correct size calculations.
> > > We're looking to add this and would like to do all the virtchnl
> > > structure fixes in one series.
> > >
> > 
> > Oh OK, I see. In this case, I think something like this might work just
> > fine:
> > 
> > https://git.kernel.org/linus/c0a744dcaa29e9537e8607ae9c965ad936124a4d
> > 
> > What do you think?
> > 
> 
> About half our virtchnl structures correctly validate the length (i.e. enforcing that the number of members including the implicit one are correct). There are maybe 3-4 which don't do that and accidentally allow sizes that are off by 1 member.
> 
> We believe the correct fix is to fix the structure definitions to use [] and then introduce a VALIDATE_MSG_V2 feature flag which is negotiated by the VF indicating whether it supports this behavior, and the PF replying to VF if it supports.
> 
> In the case where the VF doesn't support this, the PF will notice this and modify its length calculations for the handful of currently broken checks to include one extra member. In the case where the VF supports this but the PF does not, the VF must allocate extra memory and ensure it passes the larger message length. In the case where both PF and VF support the new "feature" we'll correctly switch to using 0 length flexible arrays.
> 
> It's actually even slightly more convoluted because another 3-4 ops only mis-validate the size when the length of the flexible array is 0. In that case, they require the full size of the structure, but in the case where it's 1 or more, they require the size to match as you would expect with a 0-sized array.
> 
> I'm not sure the union approach is suitable for that? We believe the use of a new capability bit is the best mechanism: we can fix the code to use flexible array definitions everywhere and simply ensure that when communicating with old PF or VF, we add additional padding as necessary to the message.

It seems like this can all be solved easily without versioning nor
unions. Currently, VIRTCHNL_OP_CONFIG_VSI_QUEUES requires that "msglen"
must be the header (struct virtchnl_vsi_queue_config_info) and at least
1 trailing qpair (struct virtchnl_queue_pair_info). There's no reason to
change this requirement.

We can leave the "over allocation" that is present in
drivers/net/ethernet/intel/iavf/iavf_virtchnl.c too:


diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 0eab3c43bdc5..66c3d1442ced 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -256,7 +256,7 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 		return;
 	}
 	adapter->current_op = VIRTCHNL_OP_CONFIG_VSI_QUEUES;
-	len = struct_size(vqci, qpair, pairs);
+	len = struct_size(vqci, qpair, pairs + 1);
 	vqci = kzalloc(len, GFP_KERNEL);
 	if (!vqci)
 		return;
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 8612f8fc86c1..d8d30dc98cd1 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -338,10 +338,10 @@ struct virtchnl_vsi_queue_config_info {
 	u16 vsi_id;
 	u16 num_queue_pairs;
 	u32 pad;
-	struct virtchnl_queue_pair_info qpair[1];
+	struct virtchnl_queue_pair_info qpair[0];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_vsi_queue_config_info);
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_vsi_queue_config_info);
 
 /* VIRTCHNL_OP_REQUEST_QUEUES
  * VF sends this message to request the PF to allocate additional queues to
@@ -993,18 +993,19 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_CONFIG_RX_QUEUE:
 		valid_len = sizeof(struct virtchnl_rxq_info);
 		break;
-	case VIRTCHNL_OP_CONFIG_VSI_QUEUES:
-		valid_len = sizeof(struct virtchnl_vsi_queue_config_info);
+	case VIRTCHNL_OP_CONFIG_VSI_QUEUES: {
+		struct virtchnl_vsi_queue_config_info *vqc =
+		    (struct virtchnl_vsi_queue_config_info *)msg;
+
+		valid_len = struct_size(vqc, qpair, 1);
 		if (msglen >= valid_len) {
-			struct virtchnl_vsi_queue_config_info *vqc =
-			    (struct virtchnl_vsi_queue_config_info *)msg;
-			valid_len += (vqc->num_queue_pairs *
-				      sizeof(struct
-					     virtchnl_queue_pair_info));
+			valid_len += flex_array_size(vqc, qpair,
+						     vqc->num_queue_pairs);
 			if (vqc->num_queue_pairs == 0)
 				err_msg_format = true;
 		}
 		break;
+	}
 	case VIRTCHNL_OP_CONFIG_IRQ_MAP:
 		valid_len = sizeof(struct virtchnl_irq_map_info);
 		if (msglen >= valid_len) {



The above is a no-op change, and switches to flex arrays.

Additionally, these should be fixed as well:

struct virtchnl_vf_resource
struct virtchnl_irq_map_info
struct virtchnl_ether_addr_list
struct virtchnl_vlan_filter_list
struct virtchnl_rss_key
struct virtchnl_rss_lut
struct virtchnl_tc_info
struct virtchnl_iwarp_qvlist_info


-- 
Kees Cook

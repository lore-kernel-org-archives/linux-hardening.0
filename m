Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92814C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 15:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CB961090
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 15:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhJOPzQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Oct 2021 11:55:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:44995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhJOPzP (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Oct 2021 11:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634313181;
        bh=+UHew0luVMjbFHLFFxpMVAj6c4oCiqqrwNFkNSmpVnc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bNMoRusyJ3ZAITJjBXEGnrF/VZf/Lg1Tc1XGprY/P+wmg7YOSAvz1H0PrrNBvpEw4
         rRNswxHoPFTOPwrRpArgTEYu+MJCb8p/kj4qqLkHoSg3E8zF9z+Qo563/UY/1Zstc6
         Fig975eH6tseR0OkPg9TCHQcpcg70i502R2TEUwc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOiHf-1mNTvO2Jjz-00QBxU; Fri, 15
 Oct 2021 17:53:01 +0200
Date:   Fri, 15 Oct 2021 17:52:48 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Li Fei1 <fei1.li@intel.com>
Cc:     Len Baker <len.baker@gmx.com>, keescook@chromium.org,
        gustavoars@kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: Prefer array_syze and struct_size over open
 coded arithmetic
Message-ID: <20211015155248.GA3289@titan>
References: <20211011103902.15638-1-len.baker@gmx.com>
 <20211012013429.GA28284@louislifei-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012013429.GA28284@louislifei-OptiPlex-7050>
X-Provags-ID: V03:K1:8I+AheHcTcMLiJ9hfpPED3m8oSKH+eBB1bHCp+r/xQVcTprDcm5
 KBjwwnuV0I8gSMJkr/DGJSkw5Eh17+rMInQaQDotNJwy1e/kdlFWsLwb6BUCPV1DgRreeu/
 4lN1pSKPBSNicTfDn3rogaqBhNbBziQrLjiaKyqmAOSmYqhmyIrADq5RxNuqrYXhad4gwzO
 0vzVDRxos3NRV6UgnXjCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VPU8bzKmywU=:8hWSVEQaIaHe5wtqLtao/J
 HLmxpJlmhigxNo9PyfGSlvuOZREkvznZNMpECXE/P3iC8febf8b31ZEuyWy6OprJb1J07dO2h
 PUAEa2fQKDUQmzjUd26HvlcWFQ9kbI9Kqtwu4LOt3Iys0RY6ScTPKu+JdHqadjzZ4CNPhaT6j
 dGFmALgUGolB9H2DFL/DcR3NskXry6fmKU90n/Zy4RjuQ4jndk7gM+ONMB9LCmish2ojRelu6
 uk8XZIEjTFEIxbH+XXEejEYnx2SCPIjAAtgkBdK5DZzJeob4Yk33+FiC4WD+rhd/qsM+EyEFy
 jYYnXGmuq/ir7knbSrvFzyIoJzd8TmbY7iorvh2y4komJY/RvarTi7OuOLdEV2WfBRg7aimID
 l40T80Zn5tpBAfjxEf4ZpnXgBr4jXR2x9V6qwK9+29+LIEOfnyvsHJhJKPlWN7Xf5brow9aUw
 BIr3tjQiaJw654tHNNHB2N2aaUgrKlJDtHShSP80Web+vqQxGCf7BNWe4MsFS7n9+tZt/iMXk
 LbWWyRuN9HFdJFRtk3LwIZQDbRNu3yD6hlubhnWcL82IjbqbUTkQayzDmhXwhLUGsygcTyCss
 KNOs7sZZC5JLPtUJ+RuOt/MtFJ8I4Ia+LO170gwOQMG4Z6vRfNVk3Bl7tQP/fBaR9SDUoFXVy
 pFN1S4Q+R3PcbVeMUG6jmxPr+PEsvlhxw6z73ljex/e7WOq/w8WOZEZHyz+Vn1HfJay9iKJHl
 iUZWAXAvJtBvPGaIa65BpRH+pEut8kY84EgDWpOC6MyS0BQtOqa3FAfm/px7McLD/TIGQ/ezK
 r3ClWprt+R3IyGfoqQHeAOhX2eRWUadf/hG6VtanV6EF5dNPlZ/dUXKzdcfzMMdFQcEZK3Lut
 DnxoX3ty7pZ3XCh7C+TKtKtk2mV54ZRlawnpRrmFgofxp9n0W+PyKRk7/UYtHDwd1M/xhMTHp
 FPnKIJWEgrQmxyE+yzYdxBm0QINS3OjUjQVooEyU6KaGkXARKGiRlZ17rf4/IBtwoWt8kdmTV
 Tq2CbOpy5qJm64jQAEY80j8JXSW4gB9fHE+QncHItm7wvrzCDBM0XG+qkPbIeyKWsm8dmcYiI
 qX+ZGYM+UudPmo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Li,

On Tue, Oct 12, 2021 at 09:34:29AM +0800, Li Fei1 wrote:
> On Mon, Oct 11, 2021 at 12:39:02PM +0200, Len Baker wrote:
> > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > and Conventions" documentation [1], size calculations (especially
> > multiplication) should not be performed in memory allocator (or simila=
r)
> > function arguments due to the risk of them overflowing. This could lea=
d
> > to values wrapping around and a smaller allocation being made than the
> > caller was expecting. Using those allocations could lead to linear
> > overflows of heap memory and other misbehaviors.
> >
> > So, use the array_size() helper to do the arithmetic instead of the
> > argument "count * size" in the vzalloc() function.
> >
> > Also, take the opportunity to add a flexible array member of struct
> > vm_memory_region_op to the vm_memory_region_batch structure. And then,
> > change the code accordingly and use the struct_size() helper to do the
> > arithmetic instead of the argument "size + size * count" in the kzallo=
c
> > function.
> >
> > This code was detected with the help of Coccinelle and audited and fix=
ed
> > manually.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#ope=
n-coded-arithmetic-in-allocator-arguments
> >
> > Signed-off-by: Len Baker <len.baker@gmx.com>
>
> Hi Baker
>
> Thanks for helping us to fix this issue. This patch looks good to me.
> Please add Signed-off-by: Fei Li <fei1.li@intel.com>.

I can't add the "Signed-off-by" tag by myself. However, if you are in the
path to forward the patch to the mainline (maintainer's tree), you can
add by yourself the "Signed-off-by" tag before send a "pull" to Linus.
See [1] for more information.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html=
#sign-your-work-the-developer-s-certificate-of-origin

If you don't have a maintainer's tree, you can give (as a maintainer) an
"Acked-by" tag that then I can add to the patch. More info in [2].

[2] https://www.kernel.org/doc/html/latest/process/submitting-patches.html=
#when-to-use-acked-by-cc-and-co-developed-by

> Only two minor comments.
>
>
> > ---
> >  drivers/virt/acrn/acrn_drv.h | 10 ++++++----
> >  drivers/virt/acrn/mm.c       |  9 ++++-----
> >  2 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv=
.h
> > index 1be54efa666c..fcc2e3e5232a 100644
> > --- a/drivers/virt/acrn/acrn_drv.h
> > +++ b/drivers/virt/acrn/acrn_drv.h
> > @@ -48,6 +48,7 @@ struct vm_memory_region_op {
> >   * @reserved:		Reserved.
> >   * @regions_num:	The number of vm_memory_region_op.
> >   * @regions_gpa:	Physical address of a vm_memory_region_op array.
> > + * @regions_op:		Flexible array of vm_memory_region_op.
> One Tab please.

Sorry, but if I use only one tab, the parameters description are not all
aligned.

> >   *
> >   * HC_VM_SET_MEMORY_REGIONS uses this structure to manage EPT mapping=
s of
> >   * multiple memory regions of a User VM. A &struct vm_memory_region_b=
atch
> > @@ -55,10 +56,11 @@ struct vm_memory_region_op {
> >   * ACRN Hypervisor.
> >   */
> >  struct vm_memory_region_batch {
> > -	u16	vmid;
> > -	u16	reserved[3];
> > -	u32	regions_num;
> > -	u64	regions_gpa;
> > +	u16				vmid;
> > +	u16				reserved[3];
> > +	u32				regions_num;
> > +	u64				regions_gpa;
> > +	struct vm_memory_region_op	regions_op[];
> Please use Whitespace instead of Tab.

Sorry, but I don't understand. Do you prefer something like?:

diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index fcc2e3e5232a..5663c17ad37c 100644
=2D-- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -56,11 +56,11 @@ struct vm_memory_region_op {
  * ACRN Hypervisor.
  */
 struct vm_memory_region_batch {
-	u16				vmid;
-	u16				reserved[3];
-	u32				regions_num;
-	u64				regions_gpa;
-	struct vm_memory_region_op	regions_op[];
+	u16			   vmid;
+	u16			   reserved[3];
+	u32			   regions_num;
+	u64			   regions_gpa;
+	struct vm_memory_region_op regions_op[];
 };

 /**

Moreover, for the v2 I will fix the typo "syze->size" in the subject as
suggested Kees ;)

Regards,
Len

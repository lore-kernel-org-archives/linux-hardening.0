Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4F6C5479D
	for <linux-hardening@archiver.kernel.org>; Mon,  9 Jan 2023 10:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjAIKqS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 9 Jan 2023 05:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjAIKqQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 9 Jan 2023 05:46:16 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C0C1C5
        for <linux-hardening@vger.kernel.org>; Mon,  9 Jan 2023 02:46:14 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so12327765pjk.3
        for <linux-hardening@vger.kernel.org>; Mon, 09 Jan 2023 02:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xocq62w4PAYvFCDkydfjm5OO3Os/86g8Ghpm8AJdy7g=;
        b=OvL2lqUOcIP55k0NRmAkFXq/IIdQcDC1L1gLx2QTzeUhsP9pbauEBK2ycPQTOQ00Bc
         nqU8wPao1qqe5HERvys2MQR01/oVO3KgN3MkJp25CNyNGaiN2UFGBRMK60kfWv6+LOmM
         uCB93+zkF/on1+2lsnwwTqiJHiYJou1a83TPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xocq62w4PAYvFCDkydfjm5OO3Os/86g8Ghpm8AJdy7g=;
        b=e8dSWHPTLnrft1Np5jLeswOBuhV3C2fNL7rutGZ2DB4EUlzE+QEHGWKvI+KQ+BZX9X
         7YULeww2c76GwoVZr/atZ5xmpELJgXgcesE9Re1avXuhWkZ0u5lmWa33Mq/Mz5rTgHfD
         Y8beBjnAS452Zg7sTPosRB+xzuk6GpIH014646KkzzvtM2nUaJfadYiCHRoudVwgB928
         YjOmCRAhVFpIRLGF9jhLjLH+Ky67D3UDFfIPiPSd6EU4+My58DkJgK/ZEqwRJS3BBEdV
         s8usgsaUNFFS7esLm6gxDyOZ3f5M/V6I9MsIVLqX2MMnEdpfIvWC2cZUBVumPhgcMn9p
         dlvg==
X-Gm-Message-State: AFqh2koSCVeVLdEVp77VUXH5wWqr8xp+7TlP1tFyUa1ZMrBP1wU5XCYW
        HEKh7F2wnqeWemXRFqBzlHJ7qcKRxv9VtddbR34=
X-Google-Smtp-Source: AMrXdXs3gSsC3lZ1bbuccpQA11Vmshg6vqclc8aUQc79YaSJdVpB7WgMXK6ukIp8IK179QUi+4PQOQ==
X-Received: by 2002:a05:6a20:6988:b0:b5:dc64:87c with SMTP id t8-20020a056a20698800b000b5dc64087cmr2686386pzk.26.1673261173244;
        Mon, 09 Jan 2023 02:46:13 -0800 (PST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com. [209.85.210.182])
        by smtp.gmail.com with ESMTPSA id p6-20020aa79e86000000b0056b4c5dde61sm5933610pfq.98.2023.01.09.02.46.12
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 02:46:12 -0800 (PST)
Received: by mail-pf1-f182.google.com with SMTP id s3so3256300pfd.12
        for <linux-hardening@vger.kernel.org>; Mon, 09 Jan 2023 02:46:12 -0800 (PST)
X-Received: by 2002:a63:1709:0:b0:48c:8cc5:1b73 with SMTP id
 x9-20020a631709000000b0048c8cc51b73mr3956813pgl.520.1673261171648; Mon, 09
 Jan 2023 02:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20230106061659.never.817-kees@kernel.org> <CANiDSCtTz4mpTz4RHBzNXL=yBvXNXHBZQ-HYMFegLytoScW4eA@mail.gmail.com>
 <202301061217.816FC0313D@keescook> <Y7jODnbUqCwfwwHI@pendragon.ideasonboard.com>
In-Reply-To: <Y7jODnbUqCwfwwHI@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 9 Jan 2023 11:46:00 +0100
X-Gmail-Original-Message-ID: <CANiDSCvB8vRp43A1J4BpNZveCvG66XbDmnkKZykbWSFCLX1XUQ@mail.gmail.com>
Message-ID: <CANiDSCvB8vRp43A1J4BpNZveCvG66XbDmnkKZykbWSFCLX1XUQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Silence memcpy() run-time false positive warnings
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kees Cook <keescook@chromium.org>, ionut_n2001@yahoo.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c2124405f1d2798f"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

--000000000000c2124405f1d2798f
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

I was thinking about something on the line of the attached patch,

uvc_frame_header->data could also be replaced with a union.

Warning, not tested ;)


On Sat, 7 Jan 2023 at 02:42, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hello,
>
> On Fri, Jan 06, 2023 at 12:19:01PM -0800, Kees Cook wrote:
> > On Fri, Jan 06, 2023 at 12:43:44PM +0100, Ricardo Ribalda wrote:
> > > On Fri, 6 Jan 2023 at 07:19, Kees Cook wrote:
> > > >
> > > > The memcpy() in uvc_video_decode_meta() intentionally copies across the
> > > > length and flags members and into the trailing buf flexible array.
> > > > Split the copy so that the compiler can better reason about (the lack
> > > > of) buffer overflows here. Avoid the run-time false positive warning:
> > > >
> > > >   memcpy: detected field-spanning write (size 12) of single field "&meta->length" at drivers/media/usb/uvc/uvc_video.c:1355 (size 1)
> > > >
> > > > Additionally fix a typo in the documentation for struct uvc_meta_buf.
> > > >
> > > > Reported-by: ionut_n2001@yahoo.com
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216810
> > > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > > Cc: linux-media@vger.kernel.org
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_video.c | 4 +++-
> > > >  include/uapi/linux/uvcvideo.h     | 2 +-
> > > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > > index d2eb9066e4dc..b67347ab4181 100644
> > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > @@ -1352,7 +1352,9 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
> > > >         if (has_scr)
> > > >                 memcpy(stream->clock.last_scr, scr, 6);
> > > >
> > > > -       memcpy(&meta->length, mem, length);
> > > > +       meta->length = mem[0];
> > > > +       meta->flags  = mem[1];
> > > > +       memcpy(meta->buf, &mem[2], length - 2);
> > > >         meta_buf->bytesused += length + sizeof(meta->ns) + sizeof(meta->sof);
> > > >
> > > >         uvc_dbg(stream->dev, FRAME,
> > > > diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
> > > > index 8288137387c0..a9d0a64007ba 100644
> > > > --- a/include/uapi/linux/uvcvideo.h
> > > > +++ b/include/uapi/linux/uvcvideo.h
> > > > @@ -86,7 +86,7 @@ struct uvc_xu_control_query {
> > > >   * struct. The first two fields are added by the driver, they can be used for
> > > >   * clock synchronisation. The rest is an exact copy of a UVC payload header.
> > > >   * Only complete objects with complete buffers are included. Therefore it's
> > > > - * always sizeof(meta->ts) + sizeof(meta->sof) + meta->length bytes large.
> > > > + * always sizeof(meta->ns) + sizeof(meta->sof) + meta->length bytes large.
> > > >   */
> > > >  struct uvc_meta_buf {
> > > >         __u64 ns;
> > > [...]
> > >
> > > Would it make more sense to replace *mem with a structure/union. Something like:
> > > https://patchwork.linuxtv.org/project/linux-media/patch/20221214-uvc-status-alloc-v4-0-f8e3e2994ebd@chromium.org/
> >
> > I wasn't sure -- it seemed like this routine was doing the serializing
> > into a struct already and an additional struct overlay wasn't going to
> > improve readability. But I can certainly do that if it's preferred!
>
> I'm not sure to see how using an additional struct or union would help.
> We can't use struct assignment as the data may be unaligned, so memcpy()
> is required. The issue isn't with the source operand of the memcpy() but
> with the destination operand. Ricardo, if I'm missing something, please
> submit an alternative patch to explain what you meant.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

--000000000000c2124405f1d2798f
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-media-uvcvideo-Refactor-uvc_video_decode_meta.patch"
Content-Disposition: attachment; 
	filename="0001-media-uvcvideo-Refactor-uvc_video_decode_meta.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lcooeez80>
X-Attachment-Id: f_lcooeez80

RnJvbSBkY2U3MmZlN2YwMDNiYTQwYmEyZDUzNGU1Zjg0YmFmYzczYjM3MzE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSaWNhcmRvIFJpYmFsZGEgPHJpYmFsZGFAY2hyb21pdW0ub3Jn
PgpEYXRlOiBNb24sIDkgSmFuIDIwMjMgMTE6NDI6MjEgKzAxMDAKU3ViamVjdDogW1BBVENIXSBt
ZWRpYTogdXZjdmlkZW86IFJlZmFjdG9yIHV2Y192aWRlb19kZWNvZGVfbWV0YQoKTk9UIFRFU1RF
RCEKClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gUmliYWxkYSA8cmliYWxkYUBjaHJvbWl1bS5vcmc+
Ci0tLQogZHJpdmVycy9tZWRpYS91c2IvdXZjL3V2Y192aWRlby5jIHwgNTggKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDIx
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvdXNiL3V2Yy91dmNfdmlk
ZW8uYyBiL2RyaXZlcnMvbWVkaWEvdXNiL3V2Yy91dmNfdmlkZW8uYwppbmRleCAwNGY0NTJkOTVm
ZDYuLmY2YzA5MTYyNmYzYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZWRpYS91c2IvdXZjL3V2Y192
aWRlby5jCisrKyBiL2RyaXZlcnMvbWVkaWEvdXNiL3V2Yy91dmNfdmlkZW8uYwpAQCAtMTMzMCw2
ICsxMzMwLDE3IEBAIHN0YXRpYyBpbnQgdXZjX3ZpZGVvX2VuY29kZV9kYXRhKHN0cnVjdCB1dmNf
c3RyZWFtaW5nICpzdHJlYW0sCiAgKiBNZXRhZGF0YQogICovCiAKK3N0cnVjdCB1dmNfZnJhbWVf
aGVhZGVyIHsKKwl1OCBsZW5ndGg7CisJdTggZmxhZ3M7CisJdTggZGF0YVtdOworfSBfX3BhY2tl
ZDsKKworc3RydWN0IHV2Y19zY3IgeworCXUzMiBzY3I7CisJdTE2IGZyYW1lX3NvZjsKK30gX19w
YWNrZWQ7CisKIC8qCiAgKiBBZGRpdGlvbmFsbHkgdG8gdGhlIHBheWxvYWQgaGVhZGVycyB3ZSBh
bHNvIHdhbnQgdG8gcHJvdmlkZSB0aGUgdXNlciB3aXRoIFVTQgogICogRnJhbWUgTnVtYmVycyBh
bmQgc3lzdGVtIHRpbWUgdmFsdWVzLiBUaGUgcmVzdWx0aW5nIGJ1ZmZlciBpcyB0aHVzIGNvbXBv
c2VkCkBAIC0xMzQzLDcgKzEzNTQsOCBAQCBzdGF0aWMgaW50IHV2Y192aWRlb19lbmNvZGVfZGF0
YShzdHJ1Y3QgdXZjX3N0cmVhbWluZyAqc3RyZWFtLAogICovCiBzdGF0aWMgdm9pZCB1dmNfdmlk
ZW9fZGVjb2RlX21ldGEoc3RydWN0IHV2Y19zdHJlYW1pbmcgKnN0cmVhbSwKIAkJCQkgIHN0cnVj
dCB1dmNfYnVmZmVyICptZXRhX2J1ZiwKLQkJCQkgIGNvbnN0IHU4ICptZW0sIHVuc2lnbmVkIGlu
dCBsZW5ndGgpCisJCQkJICBjb25zdCBzdHJ1Y3QgdXZjX2ZyYW1lX2hlYWRlciAqaGVhZGVyLAor
CQkJCSAgdW5zaWduZWQgaW50IGxlbmd0aCkKIHsKIAlzdHJ1Y3QgdXZjX21ldGFfYnVmICptZXRh
OwogCXNpemVfdCBsZW5fc3RkID0gMjsKQEAgLTEzNTEsNyArMTM2Myw4IEBAIHN0YXRpYyB2b2lk
IHV2Y192aWRlb19kZWNvZGVfbWV0YShzdHJ1Y3QgdXZjX3N0cmVhbWluZyAqc3RyZWFtLAogCXVu
c2lnbmVkIGxvbmcgZmxhZ3M7CiAJdW5zaWduZWQgaW50IHNvZjsKIAlrdGltZV90IHRpbWU7Ci0J
Y29uc3QgdTggKnNjcjsKKwljb25zdCBzdHJ1Y3QgdXZjX3NjciAqc2NyOworCWNvbnN0IHUzMiAq
cHRzOwogCiAJaWYgKCFtZXRhX2J1ZiB8fCBsZW5ndGggPT0gMikKIAkJcmV0dXJuOwpAQCAtMTM2
MiwyOCArMTM3NSwzMSBAQCBzdGF0aWMgdm9pZCB1dmNfdmlkZW9fZGVjb2RlX21ldGEoc3RydWN0
IHV2Y19zdHJlYW1pbmcgKnN0cmVhbSwKIAkJcmV0dXJuOwogCX0KIAotCWhhc19wdHMgPSBtZW1b
MV0gJiBVVkNfU1RSRUFNX1BUUzsKLQloYXNfc2NyID0gbWVtWzFdICYgVVZDX1NUUkVBTV9TQ1I7
CisJaGFzX3B0cyA9IGhlYWRlci0+ZmxhZ3MgJiBVVkNfU1RSRUFNX1BUUzsKKwloYXNfc2NyID0g
aGVhZGVyLT5mbGFncyAmIFVWQ19TVFJFQU1fU0NSOwogCiAJaWYgKGhhc19wdHMpIHsKLQkJbGVu
X3N0ZCArPSA0OwotCQlzY3IgPSBtZW0gKyA2OwotCX0gZWxzZSB7Ci0JCXNjciA9IG1lbSArIDI7
CisJCXB0cyA9ICh1MzIgKikgaGVhZGVyLT5kYXRhOworCQlsZW5fc3RkICs9IHNpemVvZigqcHRz
KTsKIAl9CiAKLQlpZiAoaGFzX3NjcikKLQkJbGVuX3N0ZCArPSA2OworCWlmIChoYXNfc2NyKSB7
CisJCXU4IG9mZnNldDsKKworCQlvZmZzZXQgPSBoYXNfcHRzID8gc2l6ZW9mKCpwdHMpIDogMDsK
KwkJc2NyID0gKHN0cnVjdCB1dmNfc2NyICopIGhlYWRlci0+ZGF0YSArIG9mZnNldDsKKwkJbGVu
X3N0ZCArPSBzaXplb2Yoc3RydWN0IHV2Y19zY3IpOworCX0KIAogCWlmIChzdHJlYW0tPm1ldGEu
Zm9ybWF0ID09IFY0TDJfTUVUQV9GTVRfVVZDKQogCQlsZW5ndGggPSBsZW5fc3RkOwogCiAJaWYg
KGxlbmd0aCA9PSBsZW5fc3RkICYmICghaGFzX3NjciB8fAotCQkJCSAgIW1lbWNtcChzY3IsIHN0
cmVhbS0+Y2xvY2subGFzdF9zY3IsIDYpKSkKKwkJCQkgICFtZW1jbXAoc2NyLCBzdHJlYW0tPmNs
b2NrLmxhc3Rfc2NyLCBzaXplb2Yoc3RydWN0IHV2Y19zY3IpKSkpCiAJCXJldHVybjsKIAogCW1l
dGEgPSAoc3RydWN0IHV2Y19tZXRhX2J1ZiAqKSgodTggKiltZXRhX2J1Zi0+bWVtICsgbWV0YV9i
dWYtPmJ5dGVzdXNlZCk7Ci0JbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOworCWxvY2FsX2lycV9zYXZl
KGZsYWdzKTsgLy9kbyB3ZSBuZWVkIHRoaXM/CiAJdGltZSA9IHV2Y192aWRlb19nZXRfdGltZSgp
OwogCXNvZiA9IHVzYl9nZXRfY3VycmVudF9mcmFtZV9udW1iZXIoc3RyZWFtLT5kZXYtPnVkZXYp
OwogCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKQEAgLTEzOTEsMjAgKzE0MDcsMjAgQEAgc3Rh
dGljIHZvaWQgdXZjX3ZpZGVvX2RlY29kZV9tZXRhKHN0cnVjdCB1dmNfc3RyZWFtaW5nICpzdHJl
YW0sCiAJcHV0X3VuYWxpZ25lZChzb2YsICZtZXRhLT5zb2YpOwogCiAJaWYgKGhhc19zY3IpCi0J
CW1lbWNweShzdHJlYW0tPmNsb2NrLmxhc3Rfc2NyLCBzY3IsIDYpOworCQltZW1jcHkoc3RyZWFt
LT5jbG9jay5sYXN0X3Njciwgc2NyLCBzaXplb2Yoc3RydWN0IHV2Y19zY3IpKTsKIAotCW1ldGEt
Pmxlbmd0aCA9IG1lbVswXTsKLQltZXRhLT5mbGFncyAgPSBtZW1bMV07Ci0JbWVtY3B5KG1ldGEt
PmJ1ZiwgJm1lbVsyXSwgbGVuZ3RoIC0gMik7CisJbWV0YS0+bGVuZ3RoID0gaGVhZGVyLT5sZW5n
dGg7CisJbWV0YS0+ZmxhZ3MgID0gaGVhZGVyLT5mbGFnczsKKwltZW1jcHkobWV0YS0+YnVmLCBo
ZWFkZXItPmRhdGEsIGxlbmd0aCAtIG9mZnNldG9mKHN0cnVjdCB1dmNfZnJhbWVfaGVhZGVyLCBk
YXRhKSk7CiAJbWV0YV9idWYtPmJ5dGVzdXNlZCArPSBsZW5ndGggKyBzaXplb2YobWV0YS0+bnMp
ICsgc2l6ZW9mKG1ldGEtPnNvZik7CiAKIAl1dmNfZGJnKHN0cmVhbS0+ZGV2LCBGUkFNRSwKIAkJ
IiVzKCk6IHQtc3lzICVsbHVucywgU09GICV1LCBsZW4gJXUsIGZsYWdzIDB4JXgsIFBUUyAldSwg
U1RDICV1IGZyYW1lIFNPRiAldVxuIiwKIAkJX19mdW5jX18sIGt0aW1lX3RvX25zKHRpbWUpLCBt
ZXRhLT5zb2YsIG1ldGEtPmxlbmd0aCwKIAkJbWV0YS0+ZmxhZ3MsCi0JCWhhc19wdHMgPyAqKHUz
MiAqKW1ldGEtPmJ1ZiA6IDAsCi0JCWhhc19zY3IgPyAqKHUzMiAqKXNjciA6IDAsCi0JCWhhc19z
Y3IgPyAqKHUzMiAqKShzY3IgKyA0KSAmIDB4N2ZmIDogMCk7CisJCWhhc19wdHMgPyAqcHRzIDog
MCwKKwkJaGFzX3NjciA/IHNjci0+c2NyIDogMCwKKwkJaGFzX3NjciA/IHNjci0+ZnJhbWVfc29m
ICYgMHg3ZmYgOiAwKTsKIH0KIAogLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkBAIC0xNDc5LDcgKzE0OTUs
NyBAQCBzdGF0aWMgdm9pZCB1dmNfdmlkZW9fZGVjb2RlX2lzb2Moc3RydWN0IHV2Y191cmIgKnV2
Y191cmIsCiAJCWlmIChyZXQgPCAwKQogCQkJY29udGludWU7CiAKLQkJdXZjX3ZpZGVvX2RlY29k
ZV9tZXRhKHN0cmVhbSwgbWV0YV9idWYsIG1lbSwgcmV0KTsKKwkJdXZjX3ZpZGVvX2RlY29kZV9t
ZXRhKHN0cmVhbSwgbWV0YV9idWYsIChzdHJ1Y3QgdXZjX2ZyYW1lX2hlYWRlciAqKSBtZW0sIHJl
dCk7CiAKIAkJLyogRGVjb2RlIHRoZSBwYXlsb2FkIGRhdGEuICovCiAJCXV2Y192aWRlb19kZWNv
ZGVfZGF0YSh1dmNfdXJiLCBidWYsIG1lbSArIHJldCwKQEAgLTE1MzEsNyArMTU0Nyw3IEBAIHN0
YXRpYyB2b2lkIHV2Y192aWRlb19kZWNvZGVfYnVsayhzdHJ1Y3QgdXZjX3VyYiAqdXZjX3VyYiwK
IAkJCW1lbWNweShzdHJlYW0tPmJ1bGsuaGVhZGVyLCBtZW0sIHJldCk7CiAJCQlzdHJlYW0tPmJ1
bGsuaGVhZGVyX3NpemUgPSByZXQ7CiAKLQkJCXV2Y192aWRlb19kZWNvZGVfbWV0YShzdHJlYW0s
IG1ldGFfYnVmLCBtZW0sIHJldCk7CisJCQl1dmNfdmlkZW9fZGVjb2RlX21ldGEoc3RyZWFtLCBt
ZXRhX2J1ZiwgKHN0cnVjdCB1dmNfZnJhbWVfaGVhZGVyICopbWVtLCByZXQpOwogCiAJCQltZW0g
Kz0gcmV0OwogCQkJbGVuIC09IHJldDsKLS0gCjIuMzkuMC4zMTQuZzg0YjlhNzEzYzQxLWdvb2cK
Cg==
--000000000000c2124405f1d2798f--

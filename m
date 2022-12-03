Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAEDC4332F
	for <linux-hardening@archiver.kernel.org>; Sat,  3 Dec 2022 10:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLCK3v (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 3 Dec 2022 05:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLCK3o (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 3 Dec 2022 05:29:44 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E49989AED
        for <linux-hardening@vger.kernel.org>; Sat,  3 Dec 2022 02:29:36 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 6so1276098vkz.0
        for <linux-hardening@vger.kernel.org>; Sat, 03 Dec 2022 02:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JUP6CrYpNxiV/p8K9JSVv9oDUzAReqz9FLoTlr4dFIw=;
        b=hW2fIgAb9uOGB2AQDhitdIBH1q0QzRwV0S91M3FwHPbcseosJEwZR4+b+Oq7T1eggy
         7/T7lEaRyzjl9jt8iL/xvoCuegieXcLpkrkqOc9B00PEkHZ9lzDWIKHOqfYf75NgQ3S3
         8jpk+bCL1OdXExdd5mn3lrCqfrjn5fm6hA2hYuwUfRSMxuj3m/jECU2UVjjGJQXYsPWy
         farVKs5bhskZYD2/9t6rM54dbUxobJzSyd7gk1jzYMJMz2sjCOQpTYDyYMMZexZUkjfU
         saz19l9SRTpcT3P/qCISHqroQ+Ti+l07sjn2L0++7/N0/xPQegOyDY6xneROabFIrUNr
         cyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUP6CrYpNxiV/p8K9JSVv9oDUzAReqz9FLoTlr4dFIw=;
        b=ntpaJM31xkvHBEb9AtDBDalM+eQ5HnhyFTMGjzXzEMW0/7r01TUiOwY/C5zqBO/NMt
         EsROq/FKOIQyJNG7z8QgDx1Tni57woxO0mU1NPoKodz8WOMApKG2Ow5M++AT9EmhLsB/
         Zl+M+pCKww/u7CkzAy+ar31CjzkgqBlgoR3KPe0w6zax1bwJRjjHFuWPGb3vK/7TXKlr
         dfcIAMkA0w//2gs5T5dXkPOYk/RFc0jt+2ZyJuS4waQTDDfzYEPCaSGsoQ9ZocMSMlOL
         bfY+qi/hRRct7aEvC6kyJShQnKAZTT21BObuheHOKhsJyOyu0poIO+uszRKNVt6VojTY
         vE+A==
X-Gm-Message-State: ANoB5pnW272xwF3eJhOUUa9+l1zOjVKkpvugebJ3Ui7SZnnbs5zbepuK
        mOVr3te4WvIsCn172XC32vCZMY7HFznX4UrbKen6qw==
X-Google-Smtp-Source: AA0mqf5HECoP4TrFDs/pAQLcFF0zHyqWRtf9peYCqLRqBFGspsZBznp0FxemhLJ9CQ7Kfy0hymJSogr1KxIuKTx17HM=
X-Received: by 2002:a1f:b247:0:b0:3bb:ea0f:9330 with SMTP id
 b68-20020a1fb247000000b003bbea0f9330mr33440110vkf.4.1670063375185; Sat, 03
 Dec 2022 02:29:35 -0800 (PST)
MIME-Version: 1.0
References: <202212012008.D6F6109@keescook>
In-Reply-To: <202212012008.D6F6109@keescook>
From:   David Gow <davidgow@google.com>
Date:   Sat, 3 Dec 2022 18:29:23 +0800
Message-ID: <CABVgOSmnaa1-G_QPYjYnA+wYwS9DhW6ugO3sbTR+oOiHc6YeKQ@mail.gmail.com>
Subject: Re: mocking init_task ?
To:     Kees Cook <keescook@chromium.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, Petr Skocik <pskocik@gmail.com>,
        linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003fdf5605eee9ee9f"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

--0000000000003fdf5605eee9ee9f
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 2, 2022 at 12:28 PM Kees Cook <keescook@chromium.org> wrote:
>
> Hi,
>
> I want to make a unit test for kill_something_info(), as there is a patch
> to fix a bug with it not working as expected under a specific process
> tree arrangement[1]. This seems like a great candidate for a unit test:
> given a specific state, return a specific result. Emboldened, I applied
> the "kunit: Support redirecting function calls" series[2], preparing to
> mock group_send_sig_info(), and ran head-long into for_each_process()
> ... which uses the address of the global init_task:
>
> #define for_each_process(p) \
>         for (p = &init_task ; (p = next_task(p)) != &init_task ; )
>
> :(
>
> I'm curious what you think might be the right approach to mock
> init_task, or for_each_process(), so I can apply unit tests to some of
> the "simple" process tree walkers...

Wow -- thanks for this.

And yeah, this is really close to being really nice to test, apart
from the global state rearing its ugly head again.

Also, FYI, a version of the static stub patch which uses the static
key should be out this year (just pending cleanups to documentation /
examples / etc). You can find it here for now:
https://kunit-review.git.corp.google.com/c/linux/+/5589

>
> One idea I had was using the "kunit: Provide a static key to check if
> KUnit is actively running tests" series[3], and do something like this:
>
> #ifndef CONFIG_KUNIT
> #define init_task_ptr   &init_task
> #else
> #define init_task_ptr   ({                                      \
>                 struct task_struct *task = &init_task;          \
>                 if (static_branch_unlikely(&kunit_running)) {   \
>                         struct kunit *test;                     \
>                         test = current->kunit_test;             \
>                         if (test->mock_init_task)               \
>                                 task = test->mock_init_task;    \
>                 }                                               \
>                 task;                                           \
>         })
> #endif
>
> #define for_each_process(p) \
>         for (p = init_task_ptr ; (p = next_task(p)) != init_task_ptr ; )
>
> And then tests can hang a mock init_task off the test? It seems really
> horrible, but there is a LOT of global state in the kernel, so I figured
> I had to start somewhere? :P

I confess, I can't think of a better way to do this overall, but have
a few suggestions for the details.

My biggest worry would be if there's anything else using
for_each_process() or similar from the KUnit task context which could
cause bigger problems, though I _suspect_ we're okay. If Daniel's
suggestion for overriding things just for the test file works, that's
probably safer (though it doesn't work as well as a "generic" way of
replacing the task lists for other tests).

Related;y, in terms of overall structure, I'm not sure whether it
makes more sense to replace init_task with init_task_ptr everywhere,
or to simply have a separate definition of the macros for the KUnit
case. If this is only going to be contained to for_each_process(),
maybe just providing a separate definition of that would be easiest.
Though if we're also handling tasklist_empty(), do_each_thread(), etc.
the init_task_ptr route seems better.

If it gets more unwieldy, maybe having an always inline
get_init_task() function would be cleaner, too.

Also, the static key patch is already sitting in the kselftest/kunit
branch, and provides (as Daniel notes) the kunit_get_current_task()
function, which is cleaner to use.

Equally, instead of adding a 'mock_init_task' member to struct kunit,
it may make more sense to use a KUnit named resource. These are a
little bit slower and require a little bit more handling re: reference
counts, but mean we don't have to add a new member to struct kunit for
each new piece of mocked global state (and don't consume memory for
tests which don't need them). Documentation is here (though we do plan
to revise and simplify the API at some point in the next year):
https://docs.kernel.org/dev-tools/kunit/api/resource.html#c.kunit_find_named_resource

If this turns into a useful pattern, we could combine these to have a
kunit helper function like:
static inline void *kunit_get_mock_variable_ptr(const char
*resource_name, void *default_ptr)

This could do all of the above in one place: get the current test.
lookup the resource (handling the refcounting as needed), and
returning default_ptr if either isn't running. And it could be defined
just as default_ptr if CONFIG_KUNIT=n.

Then, init_task_ptr could just be:
#define init_task_ptr (struct task_struct
*)kunit_get_mock_variable_ptr("mock_init_task", &init_task)

(And for simpler cases which don't need to handle for loops, it'd be
possible to forgo the extra #define altogether.

Equally, we could try doing something halfway between that and the
static stub implementation, where we key off the address of the mocked
data, rather than a string.

Of course, I suspect it makes sense to try out a simpler, init_task
specific option like you suggest before going too far to design and
implement something more generic, in case there's an obvious flaw
we're missing.

Cheers,
-- David

--0000000000003fdf5605eee9ee9f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCk
PJH7tL1LPvHHGqso4BVQWIpPqZY0pDYWSgN6x2e7MjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEyMDMxMDI5MzVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAoOMSys4/VyCEHX7Fze9d
GRrYC/41X/XmBxjxRDGSIDEgxLrnMOfoou7sUngdxh0lUncRAb4qaU/uMc6AC+EFYavrfBXjL4DG
PyuJUcvJNfUrqMVNYAQPPE6ZavTlPoiA3P45Yhy8yAmX4c4dr/SFauvnQHFSiqpXUI2K0qBN5Td4
oSol196lxpA3gIu+YpcP5UZ0EGg3v1Ndn7kR+vgeAaSAEPeEGn9je0l9zVxK7Mq7BlXz6PqVmTtf
ynOOPHPmy5gsqhBZGvNFBV2rDV67NvMCVOCCvcVjkhp7Xu456FHN0cH0i/Zu8UjWRzOC469ZQUW4
ycGnWFneMyxkHz1fNA==
--0000000000003fdf5605eee9ee9f--
